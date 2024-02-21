import 'package:chat_app/utils/constant.dart';
import 'package:chat_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$logintitle",
                    style: txtBold18,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "$logindec",
                    style: txtBook14,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      socialContainer(),
                      socialContainer(),
                      socialContainer(),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      SizedBox(
                        width: 10,
                      ),
                      Text("OR"),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  customTextFiled(label: email),
                  const SizedBox(
                    height: 30,
                  ),
                  customTextFiled(label: password),
                  const SizedBox(
                    height: 177,
                  ),
                  Container(
                    height: 48,
                    width: double.infinity,
                    color: const Color(0xffF3F6F6),
                    child: Center(
                        child: Text(
                      "$loginbutton",
                      style: txtBook16,
                    )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "$forgetpass",
                    style: txtMedium14,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                      onTap: () {
                        Get.toNamed('signup');
                      },
                      child: Text(
                        "$createNewAccount",
                        style: txtMedium14,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField customTextFiled({required String label}) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(
          "$label",
          style: txtMedium14,
        ),
        labelStyle: txtMedium14,
      ),
    );
  }

  Container socialContainer() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 48,
      width: 48,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Icon(
        Icons.facebook_outlined,
        color: Colors.blue.shade900,
      ),
    );
  }
}
