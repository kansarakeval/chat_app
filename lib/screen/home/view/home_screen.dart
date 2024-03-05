import 'package:chat_app/utils/firebase/fireauth_helper.dart';
import 'package:chat_app/utils/firebase/firedb_helper.dart';
import 'package:chat_app/utils/theme/text_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        body: StreamBuilder(
          stream: FireDbHelper.fireDbHelper.readChatContact(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              List<String> id = [];
              QuerySnapshot? querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> data = querySnapshot!.docs;

              for (var x in data) {
                id.add(x.id);
              }
              return ListView.builder(
                itemCount: id.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${id[index].split(":")[0]}"),
                    subtitle: Text("${id[index].split(":")[1]}"),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('contact');
          },
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: StreamBuilder(
                stream: FireDbHelper.fireDbHelper.getProfileData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    DocumentSnapshot ds = snapshot.data!;
                    Map m1 = ds.data() as Map;

                    return Column(
                      children: [
                        m1['image'] == null
                            ? const CircleAvatar(
                                radius: 50,
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage("${m1['image']}"),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${m1['name']}",
                          style: txtBold18,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${m1['bio']}",
                          style: txtMedium14,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${m1['email']}",
                          style: txtMedium14,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${m1['mobile']}",
                          style: txtMedium14,
                        ),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )),
        ));
  }
}
