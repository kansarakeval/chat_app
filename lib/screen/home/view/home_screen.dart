import 'package:chat_app/utils/firebase/fireauth_helper.dart';
import 'package:chat_app/utils/firebase/firedb_helper.dart';
import 'package:chat_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  Future<void> getProfileData() async {
    await FireAuthHelper.fireAuthHelper.checkUser();
    await FireDbHelper.fireDbHelper.getProfileData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatApp"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FireAuthHelper.fireAuthHelper.signOut();
              Get.offAllNamed('signin');
            },
            icon: const Icon(
              Icons.login,
              color: Colors.red,
            ),
          ),
        ],

      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              FireAuthHelper.fireAuthHelper.user!.photoURL==null?const CircleAvatar(radius: 50,):CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage("${FireAuthHelper.fireAuthHelper.user!.photoURL}"),
              ),
              const SizedBox(height: 20,),
              Text("${FireAuthHelper.fireAuthHelper.user!.displayName}",style: txtBold18,),
              const SizedBox(height: 10,),
              Text("${FireAuthHelper.fireAuthHelper.user!.email}",style: txtMedium14,),
              const SizedBox(height: 10,),
              Text("${FireAuthHelper.fireAuthHelper.user!.phoneNumber}",style: txtMedium14,),
            ],
          ),
        ),
      )
    );
  }
}
