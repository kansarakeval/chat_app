import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class NotificationServices {
  static NotificationServices services = NotificationServices._();

  NotificationServices._();

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  void initNotification() {
    AndroidInitializationSettings androidInit =
    const AndroidInitializationSettings("chat");
    DarwinInitializationSettings iosInit = const DarwinInitializationSettings();

    InitializationSettings initSetting =
    InitializationSettings(android: androidInit, iOS: iosInit);
    plugin.initialize(initSetting);
  }

  Future<void> showNotification() async {
    AndroidNotificationDetails androidDetails =
    const AndroidNotificationDetails("1", "simple",
        priority: Priority.max, importance: Importance.high);
    DarwinNotificationDetails iosDetails =
    const DarwinNotificationDetails(presentBadge: true);
    NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails, iOS: iosDetails);
    await plugin.show(1, "Test Notification", "Flutter", notificationDetails);
  }

  Future<void> largeImageNotification() async {
    String image = await downloadFile(
        "https://thumbs.dreamstime.com/b/african-elephant-bull-walking-sand-road-wilderness-32046828.jpg",
        "elephant");
    AndroidNotificationDetails aDetails = AndroidNotificationDetails(
      "2", "LargeImage", largeIcon: FilePathAndroidBitmap(image),
      styleInformation: BigPictureStyleInformation(
        FilePathAndroidBitmap(image),),);
    NotificationDetails details = NotificationDetails(android:aDetails,);
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
}
