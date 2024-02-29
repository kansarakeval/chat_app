import 'dart:ffi';

import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/firebase/fireauth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireDbHelper {
  static FireDbHelper fireDbHelper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore fireDb = FirebaseFirestore.instance;

  Future<void> addProfileData(ProfileModel p1) async {
   await fireDb.collection("user").doc("${FireAuthHelper.fireAuthHelper.user!.uid}").set(
      {
        "name": p1.name,
        "mobile": p1.mobile,
        "bio": p1.bio,
        "email": p1.email,
        "address": p1.address,
        "image": p1.image,
      },
    );
  }

  Future<dynamic> getProfileData() async {
    DocumentSnapshot ds =await fireDb.collection("user").doc("${FireAuthHelper.fireAuthHelper.user!.uid}").get();
    dynamic m1 = ds.data() ;
    return m1;
  }
}
