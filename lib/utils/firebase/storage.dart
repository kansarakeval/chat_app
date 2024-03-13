import 'dart:io';

import 'package:chat_app/utils/firebase/firedb_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  static FireStorage fireStorage = FireStorage._();

  FireStorage._();

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadProfile(String path) async {
    File f1 = File(path);
    var ref = firebaseStorage.ref("profile/${f1.uri.pathSegments.last}");
    if(FireDbHelper.fireDbHelper.myProfileData.image!=null){

    }
    try {
      await ref.putFile(f1);
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print("File Not Upload${e.message}");
    }
  }
}
