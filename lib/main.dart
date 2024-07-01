//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trawell/views/homescreen.dart';
import 'package:trawell/views/market.dart';
import 'package:trawell/views/speakNative.dart';
import 'firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A bg message just showed up :  ${message.messageId}');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  await Permission.microphone.request();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        focusColor: Color.fromARGB(255, 138, 202, 255),
        hoverColor: Color.fromARGB(255, 55, 78, 142),
        primaryColorLight: Color(0xff3e97c9),
        primaryColor: Color(0xff233f8e),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
