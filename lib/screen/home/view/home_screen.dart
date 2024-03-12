import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/firebase/fireauth_helper.dart';
import 'package:chat_app/utils/firebase/firedb_helper.dart';
import 'package:chat_app/utils/services/notification_services.dart';
import 'package:chat_app/utils/theme/text_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("${state.name}");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getProfile();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> getProfile() async {
    await FireDbHelper.fireDbHelper.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatApp"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              NotificationServices.services.largeImageNotification();
            },
            icon: const Icon(Icons.notifications_none),
          ),
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
        stream: FireDbHelper.fireDbHelper.chatContact(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            List<ProfileModel> chatConact = [];
            QuerySnapshot? qs = snapshot.data;
            if (qs != null) {
              List<QueryDocumentSnapshot> qsList = qs.docs;
              for (var x in qsList) {
                List mainList = [];
                Map data = x.data() as Map;

                data.entries.forEach((e) {
                  mainList.add(e.value);
                });

                if (mainList[0]
                    .contains(FireAuthHelper.fireAuthHelper.user!.uid)) {
                  ProfileModel p1 = ProfileModel(
                    name: mainList[1][0],
                    uid: mainList[1][1],
                    image: mainList[1][2],
                    address: mainList[1][3],
                    bio: mainList[1][4],
                    email: mainList[1][5],
                    mobile: mainList[1][6],
                    notificationToken: mainList[1][7],
                    docId: x.id,
                  );
                  chatConact.add(p1);
                } else if (mainList[1]
                    .contains(FireAuthHelper.fireAuthHelper.user!.uid)) {
                  ProfileModel p1 = ProfileModel(
                    name: mainList[0][0],
                    uid: mainList[0][1],
                    image: mainList[0][2],
                    address: mainList[0][3],
                    bio: mainList[0][4],
                    email: mainList[0][5],
                    mobile: mainList[0][6],
                    notificationToken: mainList[0][7],
                    docId: x.id,
                  );
                  chatConact.add(p1);
                }
              }
            }
            return ListView.builder(
              itemCount: chatConact.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Get.toNamed('chat', arguments: chatConact[index]);
                  },
                  title: Text("${chatConact[index].name}"),
                  subtitle: Text("${chatConact[index].mobile}"),
                );
              },
            );
          }
          return const Center(
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
      ),
    );
  }
}
