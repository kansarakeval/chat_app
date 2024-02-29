import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/screen/widget/custom_text_filed.dart';
import 'package:chat_app/utils/firebase/firedb_helper.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtBio = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtImage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
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
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    ProfileModel p1 = ProfileModel(
                      name: txtName.text,
                      mobile: txtMobile.text,
                      bio: txtBio.text,
                      email: txtEmail.text,
                      address: txtAddress.text,
                      image: txtImage.text,
                    );
                    FireDbHelper.fireDbHelper.addProfileData(p1);
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
