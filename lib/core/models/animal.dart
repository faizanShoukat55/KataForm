import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'animal_note.dart';
import 'animal_weight.dart';

class Animal {
  String? animalUid;
  String? animalTag;
  File? file;
  String? animalImage;
  String? animalDOB;
  String? animalCategory;
  String? animalSex;
  String? animalWeight;
  String? animalLactation;
  String? animalGenetics;
  AnimalWeight? animalWeightObject;
  AnimalNote? animalNoteObject;
  bool? pregnantStatus;

  Animal(
      {this.animalTag,
      this.animalImage,
      this.file,
      this.animalDOB,
      this.animalCategory,
      this.animalSex,
      this.animalWeight,
      this.animalLactation,
      this.animalGenetics,
      this.animalUid,
      this.animalWeightObject,
      this.animalNoteObject,
        this.pregnantStatus
      });

  Animal.fromJson(Map<String, dynamic> json, {String? id}) {
    animalUid = id ?? json['animalUid'];
    animalTag = json['animalTag'];
    animalImage = json['animalImage'];
    animalDOB = json['animalDOB'];
    animalCategory = json['animalCategory'];
    animalSex = json['animalSex'];
    animalWeight = json['animalWeight'];
    animalLactation = json['animalLactation'];
    animalGenetics = json['animalGenetics'];
    animalWeightObject = json['animalWeightObject'] != null
        ? AnimalWeight.fromJson(json['animalWeightObject'])
        : null;
    animalNoteObject = json['animalNoteObject'] != null
        ? AnimalNote.fromJson(json['animalNoteObject'])
        : null;
    pregnantStatus = json['pregnantStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['animalTag'] = animalTag;
    data['animalImage'] = animalImage;
    data['animalDOB'] = animalDOB;
    data['animalCategory'] = animalCategory;
    data['animalSex'] = animalSex;
    data['animalUid'] = animalUid;
    data['animalGenetics'] = animalGenetics;
    data['animalWeight'] = animalWeight;
    data['animalLactation'] = animalLactation;
    if (animalWeightObject != null) {
      data['animalWeightObject'] = animalWeightObject!.toJson();
    }

    if (animalNoteObject != null) {
      data['animalNoteObject'] = animalNoteObject!.toJson();
    }

    data['pregnantStatus']=pregnantStatus;
    return data;
  }
}
