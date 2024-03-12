import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/firebase/firedb_helper.dart';
import 'package:chat_app/utils/theme/text_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Contact"),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FireDbHelper.fireDbHelper.getAllContact(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {

              List<ProfileModel> contactData = [];
              QuerySnapshot? qs = snapshot.data;
              if(qs!=null){
                List<QueryDocumentSnapshot> qsList = qs.docs;

                for (var x in qsList) {
                  Map m1 = x.data() as Map;
                  ProfileModel p1 = ProfileModel(
                    uid: m1['uid'],
                    image: m1['image'],
                    name: m1['name'],
                    bio: m1['bio'],
                    email: m1['email'],
                    mobile: m1['mobile'],
                    address: m1['address'],
                    notificationToken: m1['notificationToken']
                  );

                  contactData.add(p1);
                }
              }

              return ListView.builder(
                itemCount: contactData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Get.toNamed('chat',arguments: contactData[index]);
                    },
                    leading: contactData[index].image != null
                        ? CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage("${contactData[index].image}"),
                          )
                        : CircleAvatar(
                            radius: 30,
                            child: Text(
                              "${contactData[index].name!.substring(0, 1)}",
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ),
                    title: Text("${contactData[index].name}",style: txtBold18,),
                    subtitle: Text("${contactData[index].mobile}",style: txtBook16,),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
    );
  }
}
