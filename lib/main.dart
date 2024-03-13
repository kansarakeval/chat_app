import 'package:chat_app/utils/app_routes.dart';
import 'package:chat_app/utils/services/notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationServices.services.getFCM();
  FirebaseMessaging.onBackgroundMessage(
      NotificationServices.services.firebaseMessagingBackgroundHandler);

  NotificationServices.services.initNotification();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    routes: app_route,
  ));
}
