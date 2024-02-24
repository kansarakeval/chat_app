import 'package:chat_app/screen/widget/custom_text_filed.dart';
import 'package:chat_app/utils/constant.dart';
import 'package:chat_app/utils/firebase_helper.dart';
import 'package:chat_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtEmail =TextEditingController();
  TextEditingController txtpassword =TextEditingController();
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
                    "$registrationtitle",
                    style: txtBold18,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "$registrationdec",
                    style: txtBook14,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFiled(label: name),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFiled(label: email,controller: txtEmail,),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFiled(label: password,controller: txtpassword,),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFiled(label: confirmpassword),
                  const SizedBox(
                    height: 100,
                  ),
                  InkWell(
                    onTap: () async {
                      String msg = await FireHelper.fireHelper.singUp(email: txtEmail.text, password: txtpassword.text);
                      Get.back();
                      Get.snackbar(msg,"");
                    },
                    child: Container(
                      height: 48,
                      width: double.infinity,
                      color: const Color(0xffF3F6F6),
                      child: Center(
                        child: Text(
                          "$registrationbutton",
                          style: txtBook16,
                        ),
                      ),
                    ),
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
