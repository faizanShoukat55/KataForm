
import 'package:flutter/cupertino.dart';

import '../../../../../core/enums/view_state.dart';
import '../../../../../core/models/animal.dart';
import '../../../../../core/models/animal_family.dart';
import '../../../../../core/services/auth_services.dart';
import '../../../../../core/services/database_services.dart';
import '../../../../../core/view_model/base_view_model.dart';
import '../../../../../locator.dart';

class AnimalFamilyViewModel extends BaseViewModel {
  List<AnimalFamily> animalFamily = [];
  List<Animal> animals = [];
  late String animalID;
  final authService = locator<AuthService>();
  final dbServices = DatabaseService();

  assignValue(String aniID, List<Animal> animalList) {
    setState(ViewState.busy);
    animalID = aniID;
    animals = animalList;
    setState(ViewState.idle);
  }

  List<Animal> removeCurrentAnimal(String aniID, List<Animal> parentAnimalList) {
    //setState(ViewState.busy);

    List<Animal> newList=[];
    for(var i=0;i<parentAnimalList.length;i++){
      if (parentAnimalList[i].animalUid != aniID) {
        Animal animal=Animal.fromJson(parentAnimalList[i].toJson());
        newList.add(animal);
      }
    }
    // for (var i = 0; i < newList.length; i++) {
    //   if (newList[i].animalUid == aniID) {
    //     newList.removeAt(i);
    //     i = newList.length + 1;
    //   }
    // }
    return newList;
    // setState(ViewState.idle);
  }

  getAnimalFamily() async {
    setState(ViewState.loading);
    try {
      animalFamily.clear();
      animalFamily = await dbServices.getListOfAnimalFamily(
          authService.appUser!.uid!, animalID);

      for (int i = 0; i < animalFamily.length; i++) {
        int index = animals.indexWhere((element) =>
            element.animalUid!
                .toLowerCase()
                .compareTo(animalFamily[i].animal!.animalUid!.toLowerCase()) ==
            0);

        if (index != -1) {
          animalFamily[i].animal = null;
          animalFamily[i].animal = Animal.fromJson(
            animals[index].toJson(),
          );
        }
      }
    } catch (e, s) {
      debugPrint("AnimalHealthViewModel getAnimalFamily Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

  addFamily(AnimalFamily family) {
    setState(ViewState.busy);
    animalFamily.add(family);
    dbServices.registerAnimalFamily(animalFamily: family);
    setState(ViewState.idle);
  }

  deleteAnimalFamily(int index) {
    setState(ViewState.busy);
    try {
      dbServices.deleteAnimalFamily(
          authService.appUser!.uid!, animalID, animalFamily[index].familyID!);
      animalFamily.removeAt(index);
    } catch (e, s) {
      debugPrint("AnimalHealthViewModel deleteAnimalFamily Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

  editAnimalHealth(index, AnimalFamily animalfam) {
    setState(ViewState.busy);
    try {
      dbServices.updateAnimalFamily(
          authService.appUser!.uid!, animalID, animalfam);
      animalFamily[index] = animalfam;
    } catch (e, s) {
      debugPrint("AnimalHealthViewModel editAnimalHealth Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }
}
