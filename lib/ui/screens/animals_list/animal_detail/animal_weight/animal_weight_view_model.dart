import 'package:flutter/cupertino.dart';

import '../../../../../core/enums/view_state.dart';
import '../../../../../core/models/animal.dart';
import '../../../../../core/models/animal_weight.dart';
import '../../../../../core/others/time_handler.dart';
import '../../../../../core/services/auth_services.dart';
import '../../../../../core/services/database_services.dart';
import '../../../../../core/services/time_handler_services.dart';
import '../../../../../core/view_model/base_view_model.dart';
import '../../../../../locator.dart';
import '../../../../../main.dart';

class AnimalWeightViewModel extends BaseViewModel {
  Animal animal = Animal();
  List<AnimalWeight> animalNoteRecord = [];
  final authService = locator<AuthService>();
  late String animalID;
  final dbServices = DatabaseService();

  // AnimalWeightViewModel(Animal? currentAnimal) {
  //   if (currentAnimal!=null) {
  //     animal = currentAnimal;
  //   }
  //
  // }



  assignValue(String aniID,Animal updatedAnimal) {
    setState(ViewState.busy);
    animalID = aniID;
    animal=updatedAnimal;
    setState(ViewState.idle);
  }

  getAnimalWeight() async {
    setState(ViewState.loading);
    try {
      animalNoteRecord.clear();
      animalNoteRecord = await dbServices.getListOfAnimalWeight(authService.appUser!.uid!, animalID);

      ///Todo.......Sort the array on date basis
      // if (animalNoteRecord.isNotEmpty) {
      //   var milkDate=formatTimeStampOfHealth(animalNoteRecord[0].weightDate!);
      //   var currentDate=formatTimeStampOfHealth(Timestamp.now());
      //
      //   // animalNoteRecord.sort()
      // }

      findTotalWeight();
    } catch (e, s) {
      debugPrint("AnimalHealthViewModel getAnimalNote Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

  findTotalWeight() {
    setState(ViewState.loading);
    int highIndex = -1;
    int highKg = -1;
    for (int i = 0; i < animalNoteRecord.length; i++) {
      int totalKg = int.parse("${animalNoteRecord[i].totalKg}");
      int lastTotalKg =
          int.parse("${animalNoteRecord[animalNoteRecord.length - 1].totalKg}");
      int difference=lastTotalKg - totalKg;
      if (difference<=0) {
        difference=0;
      }
      animalNoteRecord[i].difference = "$difference";
      animalNoteRecord[i].isHighest = false;

      if (highKg <= totalKg) {
        highKg = totalKg;
        highIndex = i;
      }
    }
    if (animalNoteRecord.isNotEmpty) {
      animalNoteRecord[highIndex].isHighest = true;
    }
    setState(ViewState.busy);
  }

  addAnimalWeight(AnimalWeight animalWeight) {
    setState(ViewState.busy);

    try {
      AnimalWeight weight = AnimalWeight(
          animalID: animalID,
          farmOwnerID: authService.appUser!.uid!,
          animalWeightUid: uid() + DateTime.now().microsecondsSinceEpoch.toString(),
          totalKg: animalWeight.totalKg,
          weightDate: animalWeight.weightDate,
          difference: "0");
      animalNoteRecord.add(weight);
      dbServices.registerAnimalWeight(animalWeight: weight);
      findTotalWeight();

      ///Todo: add animal weight and update record on fire store.
      animal.animalWeight=weight.totalKg;
      animal.animalWeightObject=weight;
      logger.e("Animal Weight :${animal.animalWeightObject?.weightDate}");
      updateAnimalOnServer();

    } catch (e, s) {
      debugPrint("AnimalHealthViewModel addAnimalNote Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

  deleteAnimalWeight(int index) {
    setState(ViewState.busy);
    try {
      dbServices.deleteAnimalWeight(authService.appUser!.uid!, animalID,
          animalNoteRecord[index].animalWeightUid!);
      animalNoteRecord.removeAt(index);
      findTotalWeight();
    } catch (e, s) {
      debugPrint("AnimalHealthViewModel deleteAnimalNote Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

  editAnimalNote(index, AnimalWeight animalNote) {
    setState(ViewState.busy);
    try {
      dbServices.updateAnimalWeight(
          authService.appUser!.uid!, animalID, animalNote);
      animalNoteRecord[index] = animalNote;
      findTotalWeight();
    } catch (e, s) {
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
