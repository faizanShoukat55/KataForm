
import 'package:flutter/cupertino.dart';

import '../../../../../core/enums/view_state.dart';
import '../../../../../core/models/animal_health.dart';
import '../../../../../core/others/time_handler.dart';
import '../../../../../core/services/auth_services.dart';
import '../../../../../core/services/database_services.dart';
import '../../../../../core/view_model/base_view_model.dart';
import '../../../../../locator.dart';

class AnimalHealthViewModel extends BaseViewModel{
  List<AnimalHealth> animalHealthRecord = [];
  final authService = locator<AuthService>();
  late String animalID;
  final dbServices = DatabaseService();




  assignValue(String aniID){
    setState(ViewState.busy);
    animalID = aniID;
    setState(ViewState.idle);
  }

  getAnimalHealth() async{
    setState(ViewState.loading);
    try{
      animalHealthRecord.clear();
      animalHealthRecord = await dbServices.getListOfAnimalHealth(authService.appUser!.uid!, animalID);
    }catch(e,s){
      debugPrint("AnimalHealthViewModel getAnimalHealth Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

  addAnimalHealth(AnimalHealth animalHealth){
    setState(ViewState.busy);

    try{
      AnimalHealth  health = AnimalHealth(
        animalID: animalID,
        farmOwnerID: authService.appUser!.uid!,
        healthCost: animalHealth.healthCost,
        healthTitle: animalHealth.healthTitle,
        healthDate: animalHealth.healthDate,
        healthDescription: animalHealth.healthDescription,
        animalHealthUid:  uid() + DateTime.now().microsecondsSinceEpoch.toString(),
      );
      animalHealthRecord.add(health);
      dbServices.registerAnimalHealth(animalHealth: health);
    }catch(e,s){
      debugPrint("AnimalHealthViewModel addAnimalHealth Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

  deleteAnimalHealth(int index){
    setState(ViewState.busy);
    try{
      dbServices.deleteAnimalHealth(authService.appUser!.uid!, animalID, animalHealthRecord[index].animalHealthUid!);
      animalHealthRecord.removeAt(index);
    }catch(e,s){
      debugPrint("AnimalHealthViewModel deleteAnimalHealth Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

  editAnimalHealth(index,AnimalHealth animalHealth){
    setState(ViewState.busy);
    try{
      dbServices.updateAnimalHealth(authService.appUser!.uid!, animalID, animalHealth);
      animalHealthRecord[index] = animalHealth;
    }catch(e,s){
      debugPrint("AnimalHealthViewModel editAnimalHealth Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }
}