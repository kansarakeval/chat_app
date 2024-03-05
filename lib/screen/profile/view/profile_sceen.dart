import 'package:chat_app/screen/profile/controller/profile_controller.dart';
import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/screen/widget/custom_text_filed.dart';
import 'package:chat_app/utils/firebase/fireauth_helper.dart';
import 'package:chat_app/utils/firebase/firedb_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<void> getData() async {
    await controller.getProfileData();
    if (controller.data.value != null) {
      txtName.text = controller.data.value!['name'];
      txtBio.text = controller.data.value!['bio'];
      txtMobile.text = controller.data.value!['mobile'];
      txtEmail.text = controller.data.value!['email'];
      txtAddress.text = controller.data.value!['address'];
      txtImage.text = controller.data.value!['image'];
    }
  }

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
            child: Obx(
              () => controller.data.value == null
                  ? Column(
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
                        uid: FireAuthHelper.fireAuthHelper.user!.uid,
                        name: txtName.text,
                        mobile: txtMobile.text,
                        bio: txtBio.text,
                        email: txtEmail.text,
                        address: txtAddress.text,
                        image: txtImage.text,
                      );
                      FireDbHelper.fireDbHelper.addProfileData(p1);
                      Get.offAllNamed('dash');
                    },
                    child: Text("Save"),
                  ),
                ],
              )
                  : Column(
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
                              uid: FireAuthHelper.fireAuthHelper.user!.uid,
                              name: txtName.text,
                              mobile: txtMobile.text,
                              bio: txtBio.text,
                              email: txtEmail.text,
                              address: txtAddress.text,
                              image: txtImage.text,
                            );
                            FireDbHelper.fireDbHelper.addProfileData(p1);
                            Get.offAllNamed('dash');
                          },
                          child: Text("Save"),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
