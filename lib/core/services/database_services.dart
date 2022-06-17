// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

import '../../main.dart';
import '../constants/collections.dart';
import '../models/animal.dart';
import '../models/animal_family.dart';
import '../models/animal_gallery.dart';
import '../models/animal_health.dart';
import '../models/animal_milk.dart';
import '../models/animal_note.dart';
import '../models/animal_weight.dart';
import '../models/app_user.dart';
import 'database_storage.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  static final DatabaseService _singleton = DatabaseService._internal();

  FirebaseAuth auth = FirebaseAuth.instance;

  factory DatabaseService() {
    return _singleton;
  }

  DatabaseService._internal();

  final _dbStorage = DatabaseStorageService();

  ///
  /// Register User
  ///
  registerUser(AppUser user) async {
//    print(user.id.toString() + "ID is ssss-------");
    try {
      await _db.collection('reg_user').doc(user.uid).set(user.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerUser $e');
      // ignore: avoid_print
      print(s);
    }
  }

  ///
  /// Get User
  ///
  Future<AppUser?> getUser(id) async {
    print('@getUser: id: $id');
    try {
      final snapshot = await _db.collection('reg_user').doc(id).get();
//      debugPrint('User Data: ${snapshot.data()}');
      return AppUser.fromJson(
          snapshot.data() as Map<String, dynamic>, snapshot.id);
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getUser $e');
      print(s);
      return null;
    }
  }

  ///
  /// Register Animals to Farm Regard to owner Id
  ///
  registerAnimal(
      {required Animal animal,
      required String farmOwnerId,
      File? image}) async {
    try {
      if (image != null) {
        animal.animalImage =
            await _dbStorage.uploadImage(image: image, folderName: farmOwnerId);
      }
      await _db
          .collection(farmCollection)
          .doc(farmOwnerId)
          .collection(animalsCollection)
          .doc(animal.animalUid)
          .set(animal.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAnimal $e');
      print(s);
    }
  }

  registerMultipleAnimals({
    required List<Animal> animals,
    required String farmOwnerId,
  }) async {
    try {
      CollectionReference reference = _db
          .collection(farmCollection)
          .doc(farmOwnerId)
          .collection(animalsCollection);

      for (int i = 0; i < animals.length; i++) {
        await reference.doc(animals[i].animalUid).set(animals[i].toJson());
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAnimal $e');
      print(s);
    }
  }

  ///
  /// ================= Get list of animals ================
  ///

  Future<List<Animal>> getListOfAnimals(String farmOwnerId) async {
    List<Animal> animals = [];
    try {
      final snapshot = await _db
          .collection(farmCollection)
          .doc(farmOwnerId)
          .collection(animalsCollection)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          animals.add(Animal.fromJson(snapshot.docs[i].data(),
              id: snapshot.docs[i].id));
        }
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getListOfAnimals $e');
      print(s);
    }
    return animals;
  }

  //-------------------------------- Animal Health Functions-----------------------------------------------

  ///
  /// =========== Add Animal Health =====
  ///

  registerAnimalHealth({required AnimalHealth animalHealth}) async {
    try {
      await _db
          .collection(animalHealthCollection)
          .doc(animalHealth.farmOwnerID)
          .collection(animalHealth.animalID!)
          .doc(animalHealth.animalHealthUid)
          .set(animalHealth.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAnimal $e');
      print(s);
    }
  }

  ///
  /// ======================= Get Animal Health  =========================
  ///

  Future<List<AnimalHealth>> getListOfAnimalHealth(
      String farmOwnerId, String animalID) async {
    List<AnimalHealth> animals = [];
    try {
      final snapshot = await _db
          .collection(animalHealthCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          animals.add(AnimalHealth.fromJson(
              snapshot.docs[i].data(), snapshot.docs[i].id));
        }
      }
    } catch (e, s) {
      debugPrint(
          'Exception @DatabaseService/getListOfAnimalHealth Exception $e');
      print(s);
    }
    return animals;
  }

  ///
  /// =========== Delete Animal Health ================
  ///
  deleteAnimalHealth(
      String farmOwnerId, String animalID, String healthId) async {
    try {
      await _db
          .collection(animalHealthCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .doc(healthId)
          .delete();
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/deleteAnimal Exception $e');
      print(s);
    }
  }

  ///
  /// =========== Update Animal Health ================
  ///
  updateAnimalHealth(
      String farmOwnerId, String animalID, AnimalHealth animalHealth) async {
    try {
      await _db
          .collection(animalHealthCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .doc(animalHealth.animalHealthUid)
          .update(animalHealth.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/updateAnimalHealth Exception $e');
      print(s);
    }
  }

  // --------------------------------- Animal Notes Functions ---------------------

  /// ======== Register Animal Note
  registerAnimalNote({required AnimalNote animalNote}) async {
    try {
      await _db
          .collection(animalNoteCollection)
          .doc(animalNote.farmOwnerID)
          .collection(animalNote.animalID!)
          .doc(animalNote.animalNoteUid)
          .set(animalNote.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAnimalNote $e');
      print(s);
    }
  }

  ///
  /// ======================= Get Animal Note  =========================
  ///

  Future<List<AnimalNote>> getListOfAnimalNote(
      String farmOwnerId, String animalID) async {
    List<AnimalNote> animals = [];
    try {
      final snapshot = await _db
          .collection(animalNoteCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          animals.add(AnimalNote.fromJson(snapshot.docs[i].data(),
              uid: snapshot.docs[i].id));
        }
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getListOfAnimalNote Exception $e');
      print(s);
    }
    return animals;
  }

  ///
  /// =========== Delete Animal Note ================
  ///
  deleteAnimalNote(String farmOwnerId, String animalID, String noteID) async {
    try {
      await _db
          .collection(animalNoteCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .doc(noteID)
          .delete();
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/deleteAnimalNote Exception $e');
      print(s);
    }
  }

  ///
  /// =========== Update Animal Note ================
  ///
  updateAnimalNote(
      String farmOwnerId, String animalID, AnimalNote animalNote) async {
    try {
      await _db
          .collection(animalNoteCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .doc(animalNote.animalNoteUid)
          .update(animalNote.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/updateAnimalNote Exception $e');
      print(s);
    }
  }

  // ------------------------------- Animal Weight Section Functionality ----------------------

  /// ======== Register Animal Weight
  registerAnimalWeight({required AnimalWeight animalWeight}) async {
    try {
      await _db
          .collection(animalWeightCollection)
          .doc(animalWeight.farmOwnerID)
          .collection(animalWeight.animalID!)
          .doc(animalWeight.animalWeightUid)
          .set(animalWeight.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAnimalNote $e');
      print(s);
    }
  }

  ///
  /// ======================= Get Animal Weight  =========================
  ///

  Future<List<AnimalWeight>> getListOfAnimalWeight(
      String farmOwnerId, String animalID) async {
    List<AnimalWeight> animals = [];
    try {
      final snapshot = await _db
          .collection(animalWeightCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          animals.add(AnimalWeight.fromJson(snapshot.docs[i].data(),
              uid: snapshot.docs[i].id));
        }
      }
    } catch (e, s) {
      debugPrint(
          'Exception @DatabaseService/getListOfAnimalWeight Exception $e');
      print(s);
    }
    return animals;
  }

  ///
  /// =========== Delete Animal Weight ================
  ///
  deleteAnimalWeight(String farmOwnerId, String animalID, String noteID) async {
    try {
      await _db
          .collection(animalWeightCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .doc(noteID)
          .delete();
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/deleteAnimalNote Exception $e');
      print(s);
    }
  }

  ///
  /// =========== Update Animal Weight ================
  ///
  updateAnimalWeight(
      String farmOwnerId, String animalID, AnimalWeight animalWeight) async {
    try {
      await _db
          .collection(animalWeightCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .doc(animalWeight.animalWeightUid)
          .update(animalWeight.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/updateAnimalNote Exception $e');
      print(s);
    }
  }

  //------------- Animal Gallery ---------------------

  /// ======== Register Animal Gallery
  registerAnimalGallery({required AnimalGallery animalGallery}) async {
    try {
      if (animalGallery.path != null) {
        animalGallery.imageUrl = await _dbStorage.uploadImage(image: animalGallery.path, folderName: animalGallery.farmOwnerID);
      }
      await _db
          .collection(animalGalleryCollection)
          .doc(animalGallery.farmOwnerID)
          .collection(animalGallery.animalID!)
          .doc(animalGallery.animalImageID)
          .set(animalGallery.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAnimalGallery $e');
      print(s);
    }
  }

  ///
  /// ======================= Get Animal Gallery  =========================
  ///

  Future<List<AnimalGallery>> getListOfAnimalGallery(
      String farmOwnerId, String animalID) async {
    List<AnimalGallery> animals = [];
    try {
      final snapshot = await _db
          .collection(animalGalleryCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          animals.add(AnimalGallery.fromJson(
              snapshot.docs[i].data(), snapshot.docs[i].id));
        }
      }
    } catch (e, s) {
      debugPrint(
          'Exception @DatabaseService/getListOfAnimalGallery Exception $e');
      print(s);
    }
    return animals;
  }

  ///
  /// =========== Delete Animal Gallery ================
  ///
  // deleteAnimalGallery(String farmOwnerId, String animalID, String noteID) async{
  //   try{
  //     await _db.collection(animalNoteCollection).doc(farmOwnerId).collection(animalID).doc(noteID).delete();
  //   }catch(e,s){
  //     debugPrint('Exception @DatabaseService/deleteAnimalNote Exception $e');
  //     print(s);
  //   }
  // }
  deleteAnimalGallery(
      String farmOwnerId, String animalID, String noteID) async {
    try {
      await _db
          .collection(animalGalleryCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .doc(noteID)
          .delete();
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/deleteAnimalMilk Exception $e');
      print(s);
    }
  }


  deleteAnimalGalleryFile(
      String farmOwnerId, String animalID, String noteID) async {
    try {
      // await _db
      //     .collection(animalGalleryCollection)
      //     .doc(farmOwnerId)
      //     .collection(animalID)
      //     .doc(noteID)
      //     .delete();

      //await _dbStorage.uploadImage(image: animalGallery.path, folderName: animalGallery.farmOwnerID);
      // await _db.ref(ref).delete();
      // await _db.ref("").delete();
      //await _db.doc(farmOwnerId).delete();


      // var fileName = image!.path.split("/").last;
      // final Reference storageRef = FirebaseStorage.instance.ref().child("$folderName/$fileName");

      logger.e("Parent :$farmOwnerId");
      logger.e("child :$animalID");
      FirebaseStorage.instance.ref().child(farmOwnerId).child(animalID).delete();




    } catch (e, s) {
      debugPrint('Exception @DatabaseService/deleteAnimalMilk Exception $e');
      print(s);
    }
  }

  ///
  /// =========== Update Animal Note ================
  ///
  updateAnimalGallery(
      String farmOwnerId, String animalID, AnimalNote animalNote) async {
    try {
      await _db
          .collection(animalNoteCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .doc(animalNote.animalNoteUid)
          .update(animalNote.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/updateAnimalNote Exception $e');
      print(s);
    }
  }

  // -------------------------------- Animal Milk Functionality ----- ----------

  /// ======== Register Animal Milk
  registerAnimalMilk({required AnimalMilk animalMilk}) async {
    try {
      await _db
          .collection(animalMilkCollection)
          .doc(animalMilk.farmerID)
          .collection(animalMilk.animalID!)
          .doc(animalMilk.animalMilkID)
          .set(animalMilk.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAnimalMilk $e');
      print(s);
    }
  }

  ///
  /// ======================= Get Animal Milk  =========================
  ///

  Future<List<AnimalMilk>> getListOfAnimalMilk(
      String farmOwnerId, String animalID) async {
    List<AnimalMilk> animals = [];
    try {
      final snapshot = await _db
          .collection(animalMilkCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          animals.add(AnimalMilk.fromJson(snapshot.docs[i].data(),
              id: snapshot.docs[i].id));
        }
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getListOfAnimalMilk Exception $e');
      print(s);
    }
    return animals;
  }

  ///
  /// =========== Delete Animal Gallery ================
  ///
  deleteAnimalMilk(String farmOwnerId, String animalID, String noteID) async {
    try {
      await _db
          .collection(animalMilkCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .doc(noteID)
          .delete();
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/deleteAnimalMilk Exception $e');
      print(s);
    }
  }

  ///
  /// =========== Update Animal Note ================
  ///
  updateAnimalMilk(
      String farmOwnerId, String animalID, AnimalMilk animalMilk) async {
    try {
      await _db
          .collection(animalMilkCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .doc(animalMilk.animalMilkID)
          .update(animalMilk.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/updateAnimalMilk Exception $e');
      print(s);
    }
  }

  // -------------------------------- Animal Milk Functionality ----- ----------

  /// ======== Register Animal Family
  registerAnimalFamily({required AnimalFamily animalFamily}) async {
    try {
      await _db
          .collection(animalFamilyCollection)
          .doc(animalFamily.farmOwnerID)
          .collection(animalFamily.animalID!)
          .doc(animalFamily.familyID)
          .set(animalFamily.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/registerAnimalFamily $e');
      print(s);
    }
  }

  ///
  /// ======================= Get Animal Family  =========================
  ///

  Future<List<AnimalFamily>> getListOfAnimalFamily(
      String farmOwnerId, String animalID) async {
    List<AnimalFamily> animals = [];
    try {
      final snapshot = await _db
          .collection(animalFamilyCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (int i = 0; i < snapshot.docs.length; i++) {
          animals.add(AnimalFamily.fromJson(snapshot.docs[i].data(),
              id: snapshot.docs[i].id));
        }
      }
    } catch (e, s) {
      debugPrint(
          'Exception @DatabaseService/getListOfAnimalFamily Exception $e');
      print(s);
    }
    return animals;
  }

  ///
  /// =========== Delete Animal Family ================
  ///
  deleteAnimalFamily(String farmOwnerId, String animalID, String noteID) async {
    try {
      await _db
          .collection(animalFamilyCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .doc(noteID)
          .delete();
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/deleteAnimalFamily Exception $e');
      print(s);
    }
  }

  ///
  /// =========== Update Animal Family ================
  ///
  updateAnimalFamily(
      String farmOwnerId, String animalID, AnimalFamily animalNote) async {
    try {
      await _db
          .collection(animalFamilyCollection)
          .doc(farmOwnerId)
          .collection(animalID)
          .doc(animalNote.animal!.animalUid!)
          .update(animalNote.toJson());
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/updateAnimalFamily Exception $e');
      print(s);
    }
  }
}
