// my_home_page.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shorts/Features/layout/presentation/screens/choose_video_page.dart';
import 'package:shorts/core/navigations_manager/navigations_manager.dart';

import '../../../videos_feature/presentation/screens/video_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
  }

  void _initializeFirebaseMessaging() async {
    // Ensure Firebase is initialized
    await Firebase.initializeApp();

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request notification permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            "Message received: ${message.notification?.title} - ${message.notification?.body}");
        _showNotificationDialog(
            message.notification?.title, message.notification?.body);
      });

      // Handle background and opened messages
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('Message clicked!');
      });

      // Subscribe to a specific topic (optional)
      _subscribeToAllUsersTopic();
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // Background message handler
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message: ${message.messageId}');
  }

  // Subscribe to the 'all_users' topic
  void _subscribeToAllUsersTopic() {
    _firebaseMessaging.subscribeToTopic('all_users');
    print('Subscribed to all_users topic');
  }

  // Display a dialog with notification details
  void _showNotificationDialog(String? title, String? body) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? 'Notification'),
          content: Text(body ?? 'No content'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FCM Notifications Receiver'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                NavigationManager.navigateTo(
                    context: context, screen: ChooseVideoPage());
              },
              child: const Text('upload viedo'),
            ),
            ElevatedButton(
              onPressed: () {
                NavigationManager.navigateTo(
                    context: context, screen: VideoPage());
              },
              child: const Text('Videos'),
            ),
          ],
        ));
  }
}
