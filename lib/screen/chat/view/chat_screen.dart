import 'package:chat_app/screen/chat/model/chat_model.dart';
import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/firebase/fireauth_helper.dart';
import 'package:chat_app/utils/firebase/firedb_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ProfileModel profileModel = Get.arguments;
  TextEditingController txtMsg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: profileModel.image != null
            ? CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage("${profileModel.image}"),
              )
            : CircleAvatar(
                radius: 30,
                child: Text(
                  "${profileModel.name!.substring(0, 1)}",
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
        title: Text("${profileModel.name}"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          profileModel.docId == null
              ? Container()
              : StreamBuilder(
                  stream:
                      FireDbHelper.fireDbHelper.readChat(profileModel.docId!),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      List<ChatModel> massageList = [];

                      QuerySnapshot? qs = snapshot.data;

                      if (qs != null) {
                        List<QueryDocumentSnapshot> qsDocList = qs.docs;
                        for (var x in qsDocList) {
                          Map data = x.data() as Map;

                          ChatModel c1 = ChatModel(
                            name: data['name'],
                            msg: data['msg'],
                            time: data['time'],
                            date: data['date'],
                            id: data['id'],
                            docId: x.id,
                          );
                          massageList.add(c1);
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 100),
                        child: ListView.builder(
                          reverse: true,
                          itemCount: massageList.length,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: massageList[index].id ==
                                      FireAuthHelper.fireAuthHelper.user!.uid
                                  ? Alignment.centerRight
                                  : Alignment.bottomLeft,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(
                                        massageList[index].id ==
                                                FireAuthHelper
                                                    .fireAuthHelper.user!.uid
                                            ? 10
                                            : 0),
                                    bottomRight: Radius.circular(
                                        massageList[index].id ==
                                                FireAuthHelper
                                                    .fireAuthHelper.user!.uid
                                            ? 0
                                            : 10),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: massageList[index].id ==
                                          FireAuthHelper
                                              .fireAuthHelper.user!.uid
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${massageList[index].name}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${massageList[index].msg}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: txtMsg,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () {
                        ChatModel model = ChatModel(
                          id: FireAuthHelper.fireAuthHelper.user!.uid,
                          name: FireDbHelper.fireDbHelper.myProfileData.name,
                          msg: txtMsg.text,
                          time:
                              "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
                          date:
                              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        );
                        FireDbHelper.fireDbHelper.sendMessage(
                            model,
                            FireDbHelper.fireDbHelper.myProfileData,
                            profileModel);
                        txtMsg.clear();
                      },
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
