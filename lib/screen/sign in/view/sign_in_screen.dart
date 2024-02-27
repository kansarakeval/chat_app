import 'package:chat_app/screen/widget/custom_text_filed.dart';
import 'package:chat_app/utils/constant.dart';
import 'package:chat_app/utils/firebase_helper.dart';
import 'package:chat_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

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
                    logintitle,
                    style: txtBold18,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    logindec,
                    style: txtBook14,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () async {
                            String msg=await FireHelper.fireHelper.googleSignIn();
                            Get.snackbar(msg, "Login success fully");
                            if(msg=="success")
                              {
                                Get.offAllNamed('home');
                              }
                          },
                          child: socialContainer("assets/img/google.png")),
                      socialContainer("assets/img/apple.png"),
                      socialContainer("assets/img/facebook.png"),
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
                  CustomTextFiled(
                    label: email,
                    controller: txtEmail,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFiled(
                    label: password,
                    controller: txtPassword,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  InkWell(
                    onTap: () async {
                      String msg = await FireHelper.fireHelper.singIn(
                          email: txtEmail.text, password: txtPassword.text);
                      Get.snackbar(msg, "");
                      if (msg == "success") {
                        Get.offAllNamed('home');
                      }
                    },
                    child: Container(
                      height: 48,
                      width: double.infinity,
                      color: const Color(0xffF3F6F6),
                      child: Center(
                          child: Text(
                        loginbutton,
                        style: txtBook16,
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    forgetpass,
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
                        createNewAccount,
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

  Container socialContainer(String path) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 48,
      width: 48,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Image.asset(
        path,
        height: 45,
        width: 45,
      ),
    );
  }
}
