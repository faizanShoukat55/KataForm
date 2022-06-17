import 'animal.dart';

class AnimalFamily {
  Animal? animal;
  String? animalRelationShip;
  String? animalChildNumber;
  String? farmOwnerID;
  String? familyID;
  String? animalID;

  AnimalFamily({this.animal, this.animalRelationShip, this.farmOwnerID, this.familyID,this.animalChildNumber, this.animalID});

  AnimalFamily.fromJson(Map<String, dynamic> json, {id}) {
    animal =
    json['animal'] != null ? Animal.fromJson(json['animal']) : null;
    animalRelationShip = json['animalRelationShip'];
    farmOwnerID = json['farmOwnerID'];
    animalChildNumber = json['animalChildNumber'];
    animalID = json['animalID'];
    familyID = id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.animal != null) {
      data['animal'] = this.animal!.toJson();
    }
    data['animalRelationShip'] = this.animalRelationShip;
    data['farmOwnerID'] = this.farmOwnerID;
    data['familyID'] = this.familyID;
    data['animalChildNumber'] = this.animalChildNumber;
    data['animalID'] = this.animalID;
    return data;
  }
}