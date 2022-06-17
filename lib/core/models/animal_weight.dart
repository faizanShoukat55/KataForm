// ignore_for_file: unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalWeight {
  String? animalWeightUid;
  String? animalID;
  String? farmOwnerID;
  Timestamp? weightDate;
  bool? isHighest;
  String? totalKg;
  String? difference;

  AnimalWeight({
    this.animalWeightUid,
    this.animalID,
    this.farmOwnerID,
    this.weightDate,
    this.totalKg,
    this.difference,
    this.isHighest = false,
  });

  AnimalWeight.fromJson(Map<String, dynamic> json, {uid}) {
    animalWeightUid = uid ?? json['animalWeightUid'];
    animalID = json['animalID'];
    farmOwnerID = json['farmOwnerID'];
    weightDate = json['weightDate'];
    totalKg = json['totalKg'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['animalWeightUid'] = animalWeightUid;
    data['animalID'] = animalID;
    data['farmOwnerID'] = farmOwnerID;
    data['weightDate'] = weightDate;
    data['totalKg'] = totalKg;
    return data;
  }
}
