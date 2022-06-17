import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/enums/view_state.dart';
import '../../../../../core/models/animal.dart';
import '../../../../../core/models/animal_gallery.dart';
import '../../../../../core/others/time_handler.dart';
import '../../../../../core/services/auth_services.dart';
import '../../../../../core/services/database_services.dart';
import '../../../../../core/view_model/base_view_model.dart';
import '../../../../../locator.dart';
import '../../../../../main.dart';

class AnimalGalleryViewModel extends BaseViewModel{
  String? animalPath;
  Animal animal = Animal();
  late String animalID;
  final dbServices = DatabaseService();
  final authService = locator<AuthService>();
  File? profileImage;

  List<AnimalGallery> animalGallery = [];

  assignValue(String aniID,Animal updatedAnimal){
    setState(ViewState.busy);
    animalID = aniID;
    animalPath=updatedAnimal.animalImage;
    animal=updatedAnimal;
    setState(ViewState.idle);
  }


  getAnimalGallery() async{
    setState(ViewState.loading);
    try{
      animalGallery.clear();
      animalGallery = await dbServices.getListOfAnimalGallery(authService.appUser!.uid!, animalID);
      print("Animal Gallery ${animalGallery.length}");
    }catch(e,s){
      debugPrint("AnimalHealthViewModel getAnimalHealth Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }

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
//          profileImage = File(croppedFile.path);
//          animal.file = File(croppedFile.path);
          addAnimalGallery(croppedFile.path);

        }else{
          profileImage = File(image.path);
//          animal.file = File(image.path);
          addAnimalGallery(image.path);

        }


//        String imageUrl =  await _dbStorage.uploadImage(image: profileImage, folderName: "Testing");
//        print("Image Url of Testing"+imageUrl);
//        profileImageAdded = true;
      }

    } catch (e, s) {
      print("@pickImageFromGallery() Exception $e");
      print(s);
    }
    setState(ViewState.idle);

  }

  // This funcion will helps you to pick a Video File from Camera
  pickImageFromCamera() async {
    setState(ViewState.busy);
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if(image != null){
//        profileImage = File(image.path);
        File? croppedFile =  await _cropImage(imagePath: image.path);
        if(croppedFile != null) {
//          profileImage = File(croppedFile.path);
//          animal.file = File(croppedFile.path);
        addAnimalGallery(croppedFile.path);

        }else{
          profileImage = File(image.path);
//          animal.file = File(image.path);
          addAnimalGallery(image.path);


        }


//        String imageUrl =  await _dbStorage.uploadImage(image: profileImage, folderName: "Testing");
//        print("Image Url of Testing"+imageUrl);
//        profileImageAdded = true;
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


  addAnimalGallery(String path){
    setState(ViewState.busy);

    try{

      var imageName = path.split("/").last;
      logger.e("ImageName : $imageName");

      AnimalGallery  gallery = AnimalGallery(
        animalID: animalID,
        farmOwnerID: authService.appUser!.uid!,
        path: File(path),
        animalImageID: uid() + DateTime.now().microsecondsSinceEpoch.toString(),
        imageName:imageName
      );


      animalGallery.add(gallery);
      dbServices.registerAnimalGallery(animalGallery: gallery);
    }catch(e,s){
      debugPrint("AnimalHealthViewModel addAnimalGallery Exception => $e");
      debugPrint("$s");
    }
    setState(ViewState.idle);
  }


  deleteAnimalGallery(int index){
    setState(ViewState.busy);

    ///Todo: Delete File From Firebase storage
    dbServices.deleteAnimalGalleryFile(authService.appUser!.uid!,animalGallery[index].imageName!,"");

    ///Todo: Delete Data from fire store too
    dbServices.deleteAnimalGallery(authService.appUser!.uid!, animalID, animalGallery[index].animalImageID!);
    animalGallery.removeAt(index);







    setState(ViewState.idle);
  }

  updateAnimalGallery(int index){
    setState(ViewState.busy);
    String imagePath=animalGallery[index].imageUrl??"";
    File? imageFile=animalGallery[index].path;

    animal.animalImage=imagePath;

    if (animalGallery[index].path==null) {
      animal.animalImage=imagePath;
    }else{
      animal.file=imageFile;
    }

    //animal.animalImage=imagePath;
    dbServices.registerAnimal(animal: animal, farmOwnerId: authService.appUser!.uid!, image: profileImage);
    setState(ViewState.idle);
  }


}