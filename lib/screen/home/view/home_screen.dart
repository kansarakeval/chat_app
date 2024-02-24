import 'package:chat_app/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatApp"),
        centerTitle: true,
        actions: [IconButton(onPressed: () async {
          await FireHelper.fireHelper.signOut();
          Get.offAllNamed('signin');
        }, icon: Icon(Icons.login,color: Colors.red,))],
      ),
    );
  }
}
