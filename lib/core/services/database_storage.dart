import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseStorageService{

  Future<String> uploadImage({File? image, String? folderName})async{
     String? imgUrl;

    try{
      var fileName = image!.path.split("/").last;

      final Reference storageRef = FirebaseStorage.instance.ref().child("$folderName/$fileName");
      final UploadTask uploadTask = storageRef.putFile(image);
      uploadTask.snapshotEvents.listen((event) {
        print('Uploading File Status ${event.state}');
      });

      await uploadTask.whenComplete(() async{
        print("Getting File Url");
      imgUrl = await storageRef.getDownloadURL();
      print("File Url $imgUrl");
      }
      );
    } catch (e,s){
      print("@DATABASEStorageClass uploadImage() Exception :$e");
      print(s);
    }

    return imgUrl!;
  }


  Future<String> uploadIntroVideo({File? image, String? folderName})async{
    String? videoUrl;

    try{
      var fileName = image!.path.split("/").last;

      final Reference storageRef = FirebaseStorage.instance.ref().child("$folderName/$fileName");
      final UploadTask uploadTask = storageRef.putFile(image);
      uploadTask.snapshotEvents.listen((event) {
        print('Uploading File Status ${event.state}');
      });

      await uploadTask.whenComplete(() async{
        print("Getting File Url");
        videoUrl = await storageRef.getDownloadURL();
        print("File Url $videoUrl");
      }
      );
    } catch (e,s){
      print("@DATABASEStorageClass uploadImage() Exception :$e");
      print(s);
    }

    return videoUrl!;
  }

}