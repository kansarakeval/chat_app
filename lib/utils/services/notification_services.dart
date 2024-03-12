import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class NotificationServices {
  static NotificationServices services = NotificationServices._();

  NotificationServices._();

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  FirebaseMessaging fcm = FirebaseMessaging.instance;

  void initNotification() {
    AndroidInitializationSettings androidInit =
        const AndroidInitializationSettings("chat");
    DarwinInitializationSettings iosInit = const DarwinInitializationSettings();

    InitializationSettings initSetting =
        InitializationSettings(android: androidInit, iOS: iosInit);
    plugin.initialize(initSetting);
  }

  Future<void> showNotification(String title,String body) async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails("1", "simple",
            priority: Priority.high, importance: Importance.high);
    DarwinNotificationDetails iosDetails =
        const DarwinNotificationDetails(presentBadge: true);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await plugin.show(1, title, body, notificationDetails);
  }

  Future<void> largeImageNotification() async {
    String image = await downloadFile(
        "https://thumbs.dreamstime.com/b/african-elephant-bull-walking-sand-road-wilderness-32046828.jpg",
        "elephant");
    AndroidNotificationDetails aDetails = AndroidNotificationDetails(
      "2",
      "LargeImage",
      largeIcon: FilePathAndroidBitmap(image),
      styleInformation: BigPictureStyleInformation(
        FilePathAndroidBitmap(image),
      ),
    );
    NotificationDetails details = NotificationDetails(
      android: aDetails,
    );
    plugin.show(2, "LargeImage", "Image", details);
  }

  Future<String> downloadFile(String url, String name) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String saveDestination = "${dir.path}/$name.jpg";
    File file = File(saveDestination);
    var response = await http.get(Uri.parse(url));
    file.writeAsBytes(response.bodyBytes);
    return saveDestination;
  }

  Future<void> createToken() async {
    fcm.requestPermission(provisional: true);
    String? token = await fcm.getToken();
    print("====> $token");
  }

  void getFCM() {
    createToken();
    FirebaseMessaging.onMessage.listen((event) {
      if(event.notification!=null){
        String title =event.notification!.title!;
        String body = event.notification!.body!;
        showNotification(title, body);
      }
    });
  }

  @pragma('vm:entry-point')
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    if(message!=null){
      print("Handling a background message: ${message.messageId}");
    }
  }

}
