import 'dart:io';

import 'package:chat_app/screen/profile/controller/profile_controller.dart';
import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/screen/widget/custom_text_filed.dart';
import 'package:chat_app/utils/firebase/fireauth_helper.dart';
import 'package:chat_app/utils/firebase/firedb_helper.dart';
import 'package:chat_app/utils/firebase/storage.dart';
import 'package:chat_app/utils/services/notification_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController controller = Get.put(ProfileController());
  TextEditingController txtName = TextEditingController();
  TextEditingController txtBio = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  String? image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FireDbHelper.fireDbHelper.getProfileData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              DocumentSnapshot? ds = snapshot.data;
              Map? data = ds?.data() as Map?;
              if (data != null) {
                txtName.text = data['name'];
                txtEmail.text = data['email'];
                txtMobile.text = data['mobile'];
                image = data['image'];
                txtAddress.text = data['address'];
                txtBio.text = data['bio'];
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () =>
                            controller.imagePath.value == null || image == null
                                ? CircleAvatar(
                                    radius: 50,
                                  )
                                : controller.imagePath.value == null
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundImage: FileImage(
                                            File(controller.imagePath.value!)),
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(image!),
                                      ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            ImagePicker picker = ImagePicker();
                            XFile? file = await picker.pickImage(
                                source: ImageSource.gallery);
                            controller.imagePath.value = file?.path;
                          },
                          child: Text("Image")),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFiled(
                        label: "Name",
                        controller: txtName,
                      ),
                      CustomTextFiled(
                        label: "Mobile",
                        controller: txtMobile,
                      ),
                      CustomTextFiled(
                        label: "Bio",
                        controller: txtBio,
                      ),
                      CustomTextFiled(
                        label: "Email",
                        controller: txtEmail,
                      ),
                      CustomTextFiled(
                        label: "Address",
                        controller: txtAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ProfileModel p1 = ProfileModel(
                              uid: FireAuthHelper.fireAuthHelper.user!.uid,
                              name: txtName.text,
                              mobile: txtMobile.text,
                              bio: txtBio.text,
                              email: txtEmail.text,
                              address: txtAddress.text,
                              image: null,
                              notificationToken:
                                  NotificationServices.services.token);
                          FireStorage.fireStorage.uploadProfile(controller.imagePath.value!);
                          // FireDbHelper.fireDbHelper.addProfileData(p1);
                          Get.offAllNamed('dash');
                        },
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
