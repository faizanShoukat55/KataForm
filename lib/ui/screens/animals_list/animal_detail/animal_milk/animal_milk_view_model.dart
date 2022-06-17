
import 'package:flutter/cupertino.dart';

import '../../../../../core/enums/view_state.dart';
import '../../../../../core/models/animal_milk.dart';
import '../../../../../core/others/time_handler.dart';
import '../../../../../core/services/auth_services.dart';
import '../../../../../core/services/database_services.dart';
import '../../../../../core/view_model/base_view_model.dart';
import '../../../../../locator.dart';

class AnimalMilkViewModel extends BaseViewModel{


  List<AnimalMilk> milkRecord = [];

  final authService = locator<AuthService>();
  late String animalID;
  final dbServices = DatabaseService();

  int totalFirstTimeMilk =0;
  int totalSecondTimeMilk =0;
  int totalThirdTimeMilk =0;
  int totalMilk =0;




  assignValue(String aniID){
    setState(ViewState.busy);
    animalID = aniID;
    setState(ViewState.idle);
  }

  getAnimalMilk() async{
    setState(ViewState.loading);
    try{
      milkRecord.clear();
      milkRecord = await dbServices.getListOfAnimalMilk(authService.appUser!.uid!, animalID);
      print("Milk Record is ${milkRecord.length}");
      getValue();
    }catch(e,s){
      debugPrint("AnimalHealthViewModel getAnimalNote Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

  getValue(){
    setState(ViewState.loading);
    totalMilk = 0;
    totalFirstTimeMilk = 0;
    totalSecondTimeMilk = 0;
    totalThirdTimeMilk = 0;

    for(int i = 0; i < milkRecord.length; i++){
      totalFirstTimeMilk = totalFirstTimeMilk + int.parse("${milkRecord[i].milkFirstTime}");
      totalSecondTimeMilk = totalSecondTimeMilk + int.parse("${milkRecord[i].milkSecondTime}");
      totalThirdTimeMilk = totalThirdTimeMilk + int.parse("${milkRecord[i].milkThirdTime}");

      totalMilk = totalMilk + milkRecord[i].totalMilk!;
    }
    sortList();
    setState(ViewState.idle);
  }
  sortList(){
    setState(ViewState.busy);
    milkRecord.sort((a,b) => b.totalMilk!.compareTo(a.totalMilk!));
    setState(ViewState.idle);
  }

  addMilkRecord(AnimalMilk milk){
    setState(ViewState.busy);
    AnimalMilk animalMilk = AnimalMilk(
      milkDate: milk.milkDate,
      milkFirstTime: milk.milkFirstTime,
      milkSecondTime: milk.milkSecondTime,
      milkThirdTime: milk.milkThirdTime,
      totalMilk: milk.totalMilk,
      farmerID: authService.appUser!.uid,
      animalID: animalID,
      animalMilkID:  uid() + DateTime.now().microsecondsSinceEpoch.toString(),
    );

    milkRecord.add(animalMilk);

    totalFirstTimeMilk = totalFirstTimeMilk + int.parse("${milk.milkFirstTime}");
    totalSecondTimeMilk = totalSecondTimeMilk + int.parse("${milk.milkSecondTime}");
    totalThirdTimeMilk = totalThirdTimeMilk + int.parse("${milk.milkThirdTime}");

    totalMilk = totalMilk + milk.totalMilk!;
    dbServices.registerAnimalMilk(animalMilk: animalMilk);
    sortList();
    setState(ViewState.idle);
  }

  deleteAnimalMilkRecord(int index){
    setState(ViewState.busy);
    dbServices.deleteAnimalMilk(authService.appUser!.uid!, animalID, milkRecord[index].animalMilkID!);
    milkRecord.removeAt(index);
    getValue();

    setState(ViewState.idle);
  }

  editAnimalMilk(index,AnimalMilk animalMilk){
    setState(ViewState.busy);
    try{
      dbServices.updateAnimalMilk(authService.appUser!.uid!, animalID, animalMilk);
      milkRecord[index] = animalMilk;
      getValue();

    }catch(e,s){
      debugPrint("AnimalHealthViewModel editAnimalMilk Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }






}