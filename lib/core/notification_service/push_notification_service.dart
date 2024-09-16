// import 'dart:convert';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:http/http.dart' as http;
//
// import 'notification_helper.dart';
//
// typedef NotificationCallback = void Function(String? title, String? body);
//
// class PushNotificationService implements NotificationHelper {
//   static final http.Client _client = http.Client();
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   @override
//   Future<void> initialize(NotificationCallback onMessageReceived) async {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     final settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//       FirebaseMessaging.onMessage.listen((message) {
//         final title = message.notification?.title;
//         final body = message.notification?.body;
//         print('Message received: $title - $body');
//         onMessageReceived(title, body);
//       });
//       FirebaseMessaging.onMessageOpenedApp.listen((message) {
//         print('Message clicked!');
//       });
//
//       subscribeToAllUsersTopic();
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
//
//   @override
//   Future<String> getAccessToken() async {
//     const serviceAccountJson = {
//       "type": "service_account",
//       "project_id": "video-project-39c3e",
//       "private_key_id": "e90a7e98586ca5852aab2733a648bc713fd770f0",
//       "private_key":
//           "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCWwqCKl95SXoRQ\nHX/fUFdR04GbdwYvhHJtifRFhQstk5VEvFxzoHFZDcJ6ZJq8b65I5gOE1kHjeJeZ\nCOyc/21e1+WFL2xQWw0YoxNwml6x6M0tLjZlOcbYF1/AkRU72IzPLEkXNI/MX/1x\nLB6l+TmTJeWNq5ujuvDzDgbfTH1FtDDk990khsQzF6QyW4ISApacH5CKhtCZf22p\nAxuGFMIXjepcEytYPYYIzLgk3CXijYLHE0OSPYCG4MRCO4QlSmQhGxRKsvAr6ERW\nVCBBWnW+DN7R+watVxQrb7GM/ISluNh7pU2YI78tANCT4SWP1xg7iJ8Bl//UAWYy\nfibchz/vAgMBAAECggEAPAkRSV+k5wRAiG7W5yTlQO6LJE/HpNCHiNtw7OZIR0QI\nIzEnV9xChwYVtguuGvAWZW1DZXi1EFKLfCOzpemJskUjX2A9L9qyYmc+bI7sushM\nPHu0qabSamcUeGjOHeDkYfPuv1DtGqP3F0RMiCexJ8nlmf8GobLmFMQ3NGEPWdwF\nQHc7WKdgDFhxEu5y1zC79yFFN4iRsKh9gdIDCkx2gyhs8LJcqerLotBUBc5Y3LOb\nevlU1rwZIKVUp+D2WA2mb5zYfDGSv2W7JS1lKSWkVal/cgTU4fLPdmp6/SwtFFg3\nbdvyTekb41EQeNOhiRQHL52/38sZseO4EbOU/Ql0MQKBgQDJd0xj558JhGllgJYs\nBrVkfGlN7RWOzAjjw9fXLRLtOPBcReX3LVm8X44peRpj9wWtnYiiK8HAkQs48j2Q\nHOlKP9i4m81QIcptWsSjUYo05IUkpw2VjGC4n2GsiAtaETL8OliKJjPeDVgVNceG\nMmTgfZLxPiZClYie2mKnqulduwKBgQC/kaUoh3Ko2hxjWQCgAkgBVZdqr/veTkuI\nmOrK6C/UILhaTYHX+mYE0HY53AOwMcJ9Yk8hO6CxTE6xxa+xhDrmO2ScX9WbeoFl\ny6CmmdF+jmnCVWsMp81mdmWK/xqeEX+uzHB8pNAtl4SY0ho6JZ3YrMjRCrBJn5Gd\nrjI6TsPpXQKBgFygB7QLApiKkzaChwiY0P7xIC0eqoGrlw64tNyOMZx1SDT0QgWB\niTdNK3wv3I1HPgoTWoVM3tidFu7ImLtQP4XOkuJVZ3DHCF18lNmNnKAyzHAMifdO\nwg0/4dVD+wweyjUi0iA57jDSK8QcpK4zLyPzOALIEykbvONj/mWd84sPAoGBAI5H\nuzXt27AjRsBW40r0RsyO6IX5rQTAfAM5J/GKH7PalXGkbVKfDFR5C8YPbcHYQ05i\nzMivA7uLJEuOut4KisBizmgCGaF/jEmxwmDaj6kCVvRaAscEfl6iguqIbBmIf5+x\nAb7hniiuh3IFYitbsu+x7Pitip8z37AQKAf8Zi+VAoGAEI0u6UqVlDCMxc4XwGrf\nuvuLITJwy0RfgCNcWJZCLLuT9h0k+WoJm4SB6+9b72SkFNqksXNQM5ZLHJphk/VE\nKJqziIWB41C6aoLK9Mfg/slWa1+Yo6XJFGuv1SEmPqP8Jie+/FcRuJHZbv3XYYO4\nvSLEWDbOGZuBx6mK8skaYRg=\n-----END PRIVATE KEY-----\n",
//       "client_email":
//           "nasser-flutter@video-project-39c3e.iam.gserviceaccount.com",
//       "client_id": "105231681385787921417",
//       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//       "token_uri": "https://oauth2.googleapis.com/token",
//       "auth_provider_x509_cert_url":
//           "https://www.googleapis.com/oauth2/v1/certs",
//       "client_x509_cert_url":
//           "https://www.googleapis.com/robot/v1/metadata/x509/nasser-flutter%40video-project-39c3e.iam.gserviceaccount.com",
//       "universe_domain": "googleapis.com"
//     };
//
//     final scopes = [
//       "https://www.googleapis.com/auth/firebase.messaging",
//       "https://www.googleapis.com/auth/firebase.database",
//       "https://www.googleapis.com/auth/userinfo.email",
//     ];
//
//     try {
//       final credentials = await auth.obtainAccessCredentialsViaServiceAccount(
//         auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
//         scopes,
//         _client,
//       );
//       return credentials.accessToken.data;
//     } catch (e) {
//       print('Error obtaining access token: $e');
//       throw Exception('Failed to obtain access token');
//     }
//   }
//
//   @override
//   Future<void> sendNotificationToSpecificUser({
//     required String fcmToken,
//     required String userId,
//     required String title,
//     required String body,
//     required BuildContext context,
//   }) async {
//     try {
//       final accessToken = await getAccessToken();
//       final notificationPayload = {
//         "message": {
//           "token": fcmToken,
//           "notification": {"title": title, "body": body},
//           "data": {"user_id": userId},
//         }
//       };
//
//       final response = await _client.post(
//         Uri.parse(
//             'https://fcm.googleapis.com/v1/projects/video-project-39c3e/messages:send'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $accessToken',
//         },
//         body: jsonEncode(notificationPayload),
//       );
//
//       if (response.statusCode == 200) {
//         _showDialog(context, 'Success', 'Notification sent successfully.');
//       } else {
//         _showDialog(
//             context, 'Error', 'Error sending notification: ${response.body}');
//       }
//     } catch (e) {
//       _showDialog(context, 'Error', 'Error sending notification: $e');
//     }
//   }
//
//   @override
//   void subscribeToAllUsersTopic() {
//     _firebaseMessaging.subscribeToTopic('allUsers');
//   }
//
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     await Firebase.initializeApp();
//     print(
//         'Background message: ${message.notification?.title ?? ''} - ${message.notification?.body ?? ''}');
//   }
//
//   void _showDialog(BuildContext context, String title, String message) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (context.mounted) {
//         showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: Text(title),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     });
//   }
// }
