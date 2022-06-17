import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalHealth {
  String? healthTitle;
  String? animalHealthUid;
  String? animalID;
  String? farmOwnerID;
  String? healthCost;
  Timestamp? healthDate;
  String? healthDescription;

  AnimalHealth(
      {this.healthTitle,
        this.animalHealthUid,
        this.animalID,
        this.farmOwnerID,
        this.healthCost,
        this.healthDate,
        this.healthDescription});

  AnimalHealth.fromJson(Map<String, dynamic> json, uid) {
    healthTitle = json['healthTitle'];
    animalHealthUid = uid;
    animalID = json['animalID'];
    farmOwnerID = json['farmOwnerID'];
    healthCost = json['healthCost'];
    healthDate = json['healthDate'];
    healthDescription = json['healthDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['healthTitle'] = this.healthTitle;
    data['animalHealthUid'] = this.animalHealthUid;
    data['animalID'] = this.animalID;
    data['farmOwnerID'] = this.farmOwnerID;
    data['healthCost'] = this.healthCost;
    data['healthDate'] = this.healthDate;
    data['healthDescription'] = this.healthDescription;
    return data;
  }
}
