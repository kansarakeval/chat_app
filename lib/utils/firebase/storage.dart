import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  static FireStorage fireStorage = FireStorage._();

  FireStorage._();

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> uploadProfile(String path) async {
    File f1 = File(path);
    var ref = firebaseStorage.ref("profile/${f1.uri.pathSegments.last}");
    try {
      await ref.putFile(f1);
    } on FirebaseException catch (e) {
      print("File Not Upload${e.message}");
    }
  }
}
