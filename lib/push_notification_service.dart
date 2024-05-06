import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PushNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data.values}');
      Fluttertoast.showToast(msg: "notifications we have ${message.notification?.title}");


      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification?.title}');
      }
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    await getToken();
  }

  Future<void> backgroundHandler(RemoteMessage message) async {
    print('Handling a background message ${message.notification?.title}');
  }
  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    print('Token: $token');
    return token;
  }
}