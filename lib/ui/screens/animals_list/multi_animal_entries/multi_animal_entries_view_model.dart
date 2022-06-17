
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/view_state.dart';
import '../../../../core/models/animal.dart';
import '../../../../core/others/time_handler.dart';
import '../../../../core/services/auth_services.dart';
import '../../../../core/services/database_services.dart';
import '../../../../core/view_model/base_view_model.dart';
import '../../../../locator.dart';

class MultiEntriesAnimalViewModel extends BaseViewModel{
  TextEditingController animalTagController = TextEditingController();
  TextEditingController totalAnimalController = TextEditingController();
  final dbService = DatabaseService();
  final authService = locator<AuthService>();

  List<String>  category = [ "Cow", "Buffalo",  "Goat", "Sheep", "Other"];
  List<String>  animalTypes = [ "Male", "Female"];

  RangeValues rangeValues = RangeValues(0, 10);

  Animal animal = Animal();

  List<Animal> animals = [];



  updateRange(RangeValues range){
    setState(ViewState.busy);
    rangeValues = range;
    setState(ViewState.idle);
  }

  updateState(){
    setState(ViewState.busy);
    setState(ViewState.idle);
  }


  assignAnimalToList(){
    setState(ViewState.loading);
    try{
      int  val = int.parse(totalAnimalController.text);
      for( int i = 0; i < val; i++ ){
        Animal ani = Animal(
          animalTag: "${animal.animalTag} ${i+1}",
          animalCategory: animal.animalCategory,
          animalSex: animal.animalSex,
          animalUid: uid() + DateTime.now().microsecondsSinceEpoch.toString(),
        );
        animals.add(ani);
      }

    }catch(e,s){
      print("MultiEntriesAnimalViewModel Exception $e");
      print(s);
    }
    setState(ViewState.idle);
  }
  registerAnimalToServer(){
    try{
      dbService.registerMultipleAnimals(animals: animals, farmOwnerId: authService.appUser!.uid!,);
    }catch(e,s){
      print("AddAnimalViewModel registerAnimalToServer Exception  $e");
      print(s);
    }
  }
}