import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vtek/raspis.dart';
import 'ui.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin notifications =
FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
const AndroidNotificationChannel scheduleChannel =
AndroidNotificationChannel(
  'schedule',
  'Расписание',
  description: 'Уведомления об изменении расписания',
  importance: Importance.high,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  await FirebaseMessaging.instance.subscribeToTopic('schedule');

  await notifications.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(scheduleChannel);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.data['page'] == 'schedule') {
      int imgIndex = int.tryParse(message.data['image_index'] ?? '0') ?? 0;
      navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => Rasps(initialIndex: imgIndex),
      ));
    }
  });
  runApp(const MyApp());
  if (initialMessage != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      openPush(initialMessage);
    });
  }
}


void openPush(RemoteMessage message) {
  if (message.data['page'] == 'schedule') {
    final imgIndex =
        int.tryParse(message.data['image_index'] ?? '0') ?? 0;
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => Rasps(
          initialIndex: imgIndex,
        ),
      ),
    );
  }
}