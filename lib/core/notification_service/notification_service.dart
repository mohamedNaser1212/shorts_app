// // notification_service.dart
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// typedef NotificationCallback = void Function(String? title, String? body);
//
// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   static final NotificationService _instance = NotificationService._internal();
//
//   factory NotificationService() {
//     return _instance;
//   }
//
//   NotificationService._internal();
//
//   Future<void> initialize(NotificationCallback onMessageReceived) async {
//     await Firebase.initializeApp();
//
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         print(
//             "Message received: ${message.notification?.title} - ${message.notification?.body}");
//
//         onMessageReceived(
//             message.notification?.title, message.notification?.body);
//       });
//
//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//         print('Message clicked!');
//       });
//
//       _subscribeToAllUsersTopic();
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
//
//   // Background message handler
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     await Firebase.initializeApp();
//     print('Handling a background message: ${message.messageId}');
//   }
//
//   // Subscribe to the 'all_users' topic
//   void _subscribeToAllUsersTopic() {
//     _firebaseMessaging.subscribeToTopic('all_users');
//     print('Subscribed to all_users topic');
//   }
// }
