import 'dart:async';
import 'dart:convert';

// import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../firebase_options.dart';
import '../../../chat/data/models/MyRooms.dart';
import 'notificationlisten.dart';
import 'package:rxdart/rxdart.dart';

class PushNotificationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final BehaviorSubject<String> behaviorSubject = BehaviorSubject();
  final BehaviorSubject<MyRoomsDatum> behaviorchat = BehaviorSubject();
  late AndroidNotificationChannel channel;
  late MyRoomsDatum chatModel;
  late MyMessage messageDataModel;

  Future initialise({bool? isBackground, RemoteMessage? messages}) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
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
    final InitializationSettings initializationSettings =
        InitializationSettings(
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
    // initState()
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    NotificationSettings? settings;
    settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      checkData(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Got a message whilstt in the foreground!');
      print('Message data: ${message.data}');
      checkData(message);
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Handling a background message:");

    if (message.data.isNotEmpty) {
      print("Handling a background message: ${message.data}");
      checkData(message);
    }
    // showNotification(message);
  }

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
  }

  void checkData(RemoteMessage message) {
    if (message.data['note_type'].toString().contains("chat")) {
      chatModel =
          MyRoomsDatum.oneRoomFromJson(jsonDecode(message.data['room']));
      messageDataModel = MyMessage.fromJson(jsonDecode(message.data['data']));
      final notification = LocalNotification(
          "data", MyMessage.toJsonMyMessage(messageDataModel));
      behaviorchat.add(chatModel);
      if (AppRoutes.route == 'chat') {
        print('======================');
        NotificationsBloc.instance.newNotification(notification);
      } else {
        print('++++++++++++++++++++++++');
        showNotification(message, payload: message.data['room']);
      }
    } else {
      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
      showNotification(message, payload: 'dashBord');
    }
  }

  Future notificationTapBackground(NotificationResponse details) async {
    if (details.payload!.contains("dashBord")) {
      behaviorSubject.add("dashBord");
      print('انا هناااااااااااااا من الداش بورد');
    } else {
      print('يا رب تشتغل با وتريحنا ');
      behaviorSubject.add(details.payload!);
    }
  }

  ondidnotification(
      int id, String? title, String? body, String? payload) async {
    behaviorSubject.add(payload!);
  }
}
