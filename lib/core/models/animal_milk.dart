// ignore_for_file: unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalMilk {
  Timestamp? milkDate;
  String? milkFirstTime;
  String? milkSecondTime;
  String? milkThirdTime;
  String? farmerID;
  String? animalID;
  String? animalMilkID;
  int? totalMilk;

  AnimalMilk(
      {this.milkDate,
        this.milkFirstTime = "0",
        this.milkSecondTime = "0",
        this.milkThirdTime = "0",
        this.farmerID,
        this.animalID,
        this.animalMilkID,
        this.totalMilk = 0,
      });

  AnimalMilk.fromJson(Map<String, dynamic> json, {id}) {
    milkDate = json['milkDate'];
    totalMilk = json['totalMilk'] ?? 0;
    milkFirstTime = json['milkFirstTime'] ?? "0";
    milkSecondTime = json['milkSecondTime'] ?? "0";
    milkThirdTime = json['milkThirdTime'] ?? "0";
    farmerID = json['farmerID'];
    animalID = json['animalID'];
    animalMilkID = id ?? json['animalMilkID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['milkDate'] = this.milkDate;
    data['totalMilk'] = this.totalMilk;
    data['milkFirstTime'] = this.milkFirstTime;
    data['milkSecondTime'] = this.milkSecondTime;
    data['milkThirdTime'] = this.milkThirdTime;
    data['farmerID'] = this.farmerID;
    data['animalID'] = this.animalID;
    data['animalMilkID'] = this.animalMilkID;
    return data;
  }
}
