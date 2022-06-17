// ignore_for_file: unnecessary_new


import 'package:cloud_firestore/cloud_firestore.dart';

class AnimalNote {
  String? noteTitle;
  String? animalNoteUid;
  String? animalID;
  String? farmOwnerID;
  Timestamp? noteDate;

  String? noteDescription;

  AnimalNote(
      {this.noteTitle,
        this.animalNoteUid,
        this.animalID,
        this.farmOwnerID,
        this.noteDate,
        this.noteDescription});

  AnimalNote.fromJson(Map<String, dynamic> json, {uid}) {
    noteTitle = json['noteTitle'];
    animalNoteUid = uid;
    animalID = json['animalID'];
    farmOwnerID = json['farmOwnerID'];
    noteDate = json['noteDate'];
    noteDescription = json['noteDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noteTitle'] = noteTitle;
    data['animalNoteUid'] = animalNoteUid;
    data['animalID'] = animalID;
    data['farmOwnerID'] = farmOwnerID;
    data['noteDate'] = noteDate;
    data['noteDescription'] = noteDescription;
    return data;
  }
}
