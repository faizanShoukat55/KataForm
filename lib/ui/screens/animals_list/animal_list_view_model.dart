
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../core/enums/view_state.dart';
import '../../../core/models/animal.dart';
import '../../../core/services/auth_services.dart';
import '../../../core/services/database_services.dart';
import '../../../core/view_model/base_view_model.dart';
import '../../../locator.dart';
import '../../../main.dart';
import '../splash/splash_screen.dart';

class HomeViewModel extends BaseViewModel{
  final authService = locator<AuthService>();

  List<Animal> animalList = [];

  final dbService = DatabaseService();

  HomeViewModel(){
    getListOfAnimals();
  }



  getListOfAnimals() async{
    setState(ViewState.loading);
    try{
      animalList = await dbService.getListOfAnimals(authService.appUser!.uid!);
    }catch(e,s){
      debugPrint("Home ViewModel getListOfAnimals Exception $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }



  addAnimal(Animal animal){
    setState(ViewState.busy);
    animalList.add(animal);
    print("ANiimal List Length ${animalList.length}");
    setState(ViewState.idle);
  }

  update(Animal animal, int index){
    setState(ViewState.busy);
    animalList[index] = animal;
    setState(ViewState.idle);
  }

  addMultiAnimals(List<Animal> animalss){
    setState(ViewState.busy);
    animalList.addAll(animalss);
    setState(ViewState.idle);
  }
  logout() async{
    setState(ViewState.loading);
    try{
      await authService.logout();
      Get.offAll(()=> SplashScreen());
    }catch(e,s){
      debugPrint("Home ViewModel logout Exception $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }


}