
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/view_state.dart';
import '../../../../core/models/animal.dart';
import '../../../../core/view_model/base_view_model.dart';
import 'animal_health/animal_health_view_model.dart';
import 'animal_note/animal_note_view_model.dart';

class AnimalDetailViewModel extends BaseViewModel{
  late Animal animal;
  late BuildContext context;

  AnimalDetailViewModel(Animal ani, BuildContext buildContext){
    animal = ani;
//    context = buildContext;
//    init();
  }

  init() async{
    final healthViewModel = Provider.of<AnimalHealthViewModel>(context, listen: false);
    await healthViewModel.assignValue(animal.animalUid!);
    healthViewModel.getAnimalHealth();


    final noteViewModel = Provider.of<AnimalNoteViewModel>(context, listen: false);
    await noteViewModel.assignValue(animal.animalUid!,animal);
    noteViewModel.getAnimalNote();
  }

  update(Animal animal1){
    setState(ViewState.busy);
    animal = animal1;
    setState(ViewState.idle);
  }

}