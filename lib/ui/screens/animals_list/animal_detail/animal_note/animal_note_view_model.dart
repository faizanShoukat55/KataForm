
import 'package:flutter/cupertino.dart';

import '../../../../../core/enums/view_state.dart';
import '../../../../../core/models/animal.dart';
import '../../../../../core/models/animal_note.dart';
import '../../../../../core/others/time_handler.dart';
import '../../../../../core/services/auth_services.dart';
import '../../../../../core/services/database_services.dart';
import '../../../../../core/view_model/base_view_model.dart';
import '../../../../../locator.dart';
import '../../../../../main.dart';

class AnimalNoteViewModel extends BaseViewModel{
  Animal animal = Animal();
  List<AnimalNote> animalNoteRecord = [];
  final authService = locator<AuthService>();
  late String animalID;
  final dbServices = DatabaseService();




  assignValue(String aniID,Animal updatedAnimal){
    setState(ViewState.busy);
    animalID = aniID;
    animal=updatedAnimal;
    setState(ViewState.idle);
  }

  getAnimalNote() async{
    setState(ViewState.loading);
    try{
      animalNoteRecord.clear();
      animalNoteRecord = await dbServices.getListOfAnimalNote(authService.appUser!.uid!, animalID);
    }catch(e,s){
      debugPrint("AnimalHealthViewModel getAnimalNote Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

  addAnimalNote(AnimalNote animalHealth){
    setState(ViewState.busy);

    try{
      AnimalNote  note = AnimalNote(
        animalID: animalID,
        farmOwnerID: authService.appUser!.uid!,
        noteTitle: animalHealth.noteTitle,
        noteDate: animalHealth.noteDate,
        noteDescription: animalHealth.noteDescription,
        animalNoteUid:  uid() + DateTime.now().microsecondsSinceEpoch.toString(),
      );
      animalNoteRecord.add(note);
      dbServices.registerAnimalNote(animalNote: note);



      ///Todo: add animal weight and update record on fire store.
      animal.animalNoteObject=note;
      logger.e("Animal Note :${animal.animalNoteObject?.noteDescription}");
      updateAnimalOnServer();
    }catch(e,s){
      debugPrint("AnimalHealthViewModel addAnimalNote Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

  deleteAnimalNote(int index){
    setState(ViewState.busy);
    try{
      dbServices.deleteAnimalNote(authService.appUser!.uid!, animalID, animalNoteRecord[index].animalNoteUid!);
      animalNoteRecord.removeAt(index);
    }catch(e,s){
      debugPrint("AnimalHealthViewModel deleteAnimalNote Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

  editAnimalNote(index,AnimalNote animalNote){
    setState(ViewState.busy);
    try{
      dbServices.updateAnimalNote(authService.appUser!.uid!, animalID, animalNote);
      animalNoteRecord[index] = animalNote;
    }catch(e,s){
      debugPrint("AnimalHealthViewModel editAnimalNote Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

  updateAnimalOnServer() {
    try {
      dbServices.registerAnimal(animal: animal, farmOwnerId: authService.appUser!.uid!, image: null);
    } catch (e, s) {
      print("AddAnimalViewModel registerAnimalToServer Exception  $e");
      print(s);
    }
  }
}