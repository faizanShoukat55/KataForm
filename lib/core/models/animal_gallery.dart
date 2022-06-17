// ignore_for_file: unnecessary_new



import 'dart:io';

class AnimalGallery {
  File? path;
  String? imageUrl;
  String? animalID;
  String? animalImageID;
  String? farmOwnerID;
  String? imageName;

  AnimalGallery(
      {
        this.imageUrl,
        this.path,
        this.animalID,
        this.farmOwnerID,
        this.animalImageID,
        this.imageName
      });

  AnimalGallery.fromJson(Map<String, dynamic> json, uid) {
    imageUrl = json['imageUrl'];
    animalID = json['animalID'];
    farmOwnerID = json['farmOwnerID'];
    animalImageID = uid;
    imageName=json['imageName'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['animalID'] = animalID;
    data['farmOwnerID'] = farmOwnerID;
    data['animalImageID'] = animalImageID;
    data['imageName']=imageName;


    return data;
  }
}
