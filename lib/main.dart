import 'package:elwatn/app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elwatn/injector.dart' as injector;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'features/chat/data/models/MyRooms.dart';
import 'features/notification/presentation/widgets/notification.dart';
import 'features/notification/presentation/widgets/notificationlisten.dart';
import 'firebase_options.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'dart:convert';
import '../../../../config/routes/app_routes.dart';
import 'app_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  pushNotificationService.initialise();
  await injector.setup();
  BlocOverrides.runZoned(
    () => runApp(Watan()),
    blocObserver: AppBlocObserver(),
  );
}

PushNotificationService pushNotificationService = PushNotificationService();
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final BehaviorSubject<String> behaviorSubject = BehaviorSubject();
final BehaviorSubject<MyRoomsDatum> behaviorchat = BehaviorSubject();
late AndroidNotificationChannel channel;
late MyRoomsDatum chatModel;
late MyMessage messageDataModel;
void showNotification(RemoteMessage message, {String? payload}) {
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );

  if (flutterLocalNotificationsPlugin == null) {
    // initState();
    print('nullllllllllll');
    flutterLocalNotificationsPlugin!.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      payload: payload == 'dashBord' ? 'dashBord' : payload,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.max,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  } else {
    print('notttttt nulllllllll');
    flutterLocalNotificationsPlugin!.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      payload: payload == 'dashBord' ? 'dashBord' : payload,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.max,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  ////cccccccc
}

void checkData(RemoteMessage message) {
  if (message.data['note_type'].toString().contains("chat")) {
    chatModel = MyRoomsDatum.oneRoomFromJson(jsonDecode(message.data['room']));
    messageDataModel = MyMessage.fromJson(jsonDecode(message.data['data']));
    final notification =
        LocalNotification("data", MyMessage.toJsonMyMessage(messageDataModel));
    behaviorchat.add(chatModel);
    if (AppRoutes.route == 'chat') {
      NotificationsBloc.instance.newNotification(notification);
    } else {
      showNotification(message, payload: message.data['room']);
    }
  } else {
    showNotification(message, payload: 'dashBord');
  }
}

Future notificationTapBackground(NotificationResponse details) async {
  if (details.payload!.contains("dashBord")) {
    behaviorSubject.add("dashBord");
    // print('انا هناااااااااااااا من الداش بورد');
  } else {
    // print('يا رب تشتغل با وتريح/نا ');
    behaviorSubject.add(details.payload!);
  }
}

ondidnotification(int id, String? title, String? body, String? payload) async {
  behaviorSubject.add(payload!);
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Handling a background message:");
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: ondidnotification);
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux,
  );
  flutterLocalNotificationsPlugin!.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: await notificationTapBackground,
  );

  await flutterLocalNotificationsPlugin!
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  if (message.data.isNotEmpty) {
    print("Handling a background message: ${message.data}");
    checkData(message);
  }
}
