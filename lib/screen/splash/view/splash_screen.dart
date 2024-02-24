import 'dart:async';

import 'package:chat_app/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    bool isLogin = FireHelper.fireHelper.checkUser();
    Timer(
      Duration(seconds: 3),
      () => Get.offAllNamed(isLogin==false?'signin':'home'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Lottie.asset('assets/json/Animation - 1708751222448.json',
              height: 150),
        ),
      ),
    );
  }
}
