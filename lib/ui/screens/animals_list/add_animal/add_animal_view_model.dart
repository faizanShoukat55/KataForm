import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/enums/view_state.dart';
import '../../../../core/models/animal.dart';
import '../../../../core/others/time_handler.dart';
import '../../../../core/services/auth_services.dart';
import '../../../../core/services/database_services.dart';
import '../../../../core/services/database_storage.dart';
import '../../../../core/view_model/base_view_model.dart';
import '../../../../locator.dart';

class AddAnimalViewModel extends BaseViewModel{
  TextEditingController animalTagController = TextEditingController();
  TextEditingController animalWightController = TextEditingController();
  TextEditingController animalLactationController = TextEditingController();
  TextEditingController animalGenticsController = TextEditingController();
  TextEditingController dateOfBirthTextEditController = TextEditingController();

  List<String>  category = [ "Cow", "Buffalo",  "Goat", "Sheep", "Other"];
  List<String>  animalTypes = [ "Male", "Female"];
  List<String>  pregnantStatus = [ "Yes", "No"];

  File? profileImage;
  bool profileImageAdded = false;
  Animal animal  = Animal();
  final _dbStorage = DatabaseStorageService();
  final authService = locator<AuthService>();
  final dbService = DatabaseService();
  bool advanceOption = false;
  bool pregnantOption = false;



  // This funcion will helps you to pick a Video File from Camera
  pickImageFromGallery() async {
    setState(ViewState.busy);
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if(image != null){
//        profileImage = File(image.path);
        File? croppedFile =  await _cropImage(imagePath: image.path);
        if(croppedFile != null) {
          profileImage = File(croppedFile.path);
          animal.file = File(croppedFile.path);

        }else{
          profileImage = File(image.path);
          animal.file = File(image.path);

        }


//        String imageUrl =  await _dbStorage.uploadImage(image: profileImage, folderName: "Testing");
//        print("Image Url of Testing"+imageUrl);
        profileImageAdded = true;
      }

    } catch (e, s) {
      print("@pickImageFromGallery() Exception $e");
      print(s);
    }
    setState(ViewState.idle);

  }

  /// Crop Image
  Future<File?> _cropImage({required String imagePath}) async {
    File? croppedFile;
    try{

      croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
//        aspectRatio: CropAspectRatio(ratioX: 0.0, ratioY: 1.0)
        aspectRatioPresets: Platform.isAndroid
            ? [
//          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
//          CropAspectRatioPreset.ratio3x2,
//          CropAspectRatioPreset.original,
//          CropAspectRatioPreset.ratio4x3,
//          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
//          CropAspectRatioPreset.square,
//          CropAspectRatioPreset.ratio3x2,
//          CropAspectRatioPreset.ratio4x3,
//          CropAspectRatioPreset.ratio5x3,
//          CropAspectRatioPreset.ratio5x4,
//          CropAspectRatioPreset.ratio7x5,
//          CropAspectRatioPreset.ratio16x9
        ],
//        androidUiSettings: AndroidUiSettings(
//            toolbarTitle: 'Cropper',
//            toolbarColor: Colors.deepOrange,
//            toolbarWidgetColor: Colors.white,
//            initAspectRatio: CropAspectRatioPreset.original,
//            lockAspectRatio: false),
//        iosUiSettings: IOSUiSettings(
//          title: 'Cropper',
//        )
      );


    }catch(e,s){
      print("@_cropImage() Exception $e");
      print(s);
    }

    return croppedFile;

  }


  updateState(){
    setState(ViewState.idle);
    setState(ViewState.idle);
  }

  registerAnimalToServer(){
    try{
      animal.animalUid = uid() + DateTime.now().microsecondsSinceEpoch.toString();
      dbService.registerAnimal(animal: animal, farmOwnerId: authService.appUser!.uid!, image: profileImage);
    }catch(e,s){
      print("AddAnimalViewModel registerAnimalToServer Exception  $e");
      print(s);
    }
  }

}