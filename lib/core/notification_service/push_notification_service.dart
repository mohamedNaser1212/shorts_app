import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

import 'notification_helper.dart';

typedef NotificationCallback = void Function(String? title, String? body);

class PushNotificationService implements NotificationHelper {
  static final http.Client _client = http.Client();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<void> initialize(NotificationCallback onMessageReceived) async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FirebaseMessaging.onMessage.listen((message) {
        final title = message.notification?.title;
        final body = message.notification?.body;
        print('Message received: $title - $body');
        onMessageReceived(title, body);
      });
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print('Message clicked!');
      });

      subscribeToAllUsersTopic();
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Future<String> getAccessToken() async {
    const serviceAccountJson = {
      "type": "service_account",
      "project_id": "video-project-39c3e",
      "private_key_id": "e90a7e98586ca5852aab2733a648bc713fd770f0",
      "client_email":
          "nasser-flutter@video-project-39c3e.iam.gserviceaccount.com",
      "client_id": "105231681385787921417",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/nasser-flutter%40video-project-39c3e.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    final scopes = [
      "https://www.googleapis.com/auth/firebase.messaging",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/userinfo.email",
    ];

    try {
      final credentials = await auth.obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
        _client,
      );
      return credentials.accessToken.data;
    } catch (e) {
      print('Error obtaining access token: $e');
      throw Exception('Failed to obtain access token');
    }
  }

  @override
  Future<void> sendNotificationToSpecificUser({
    required String fcmToken,
    required String userId,
    required String title,
    required String body,
    required BuildContext context,
  }) async {
    try {
      final accessToken = await getAccessToken();
      final notificationPayload = {
        "message": {
          "token": fcmToken,
          "notification": {"title": title, "body": body},
          "data": {"user_id": userId},
        }
      };

      final response = await _client.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/video-project-39c3e/messages:send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(notificationPayload),
      );

      if (response.statusCode == 200) {
        _showDialog(context, 'Success', 'Notification sent successfully.');
      } else {
        _showDialog(
            context, 'Error', 'Error sending notification: ${response.body}');
      }
    } catch (e) {
      _showDialog(context, 'Error', 'Error sending notification: $e');
    }
  }

  @override
  void subscribeToAllUsersTopic() {
    _firebaseMessaging.subscribeToTopic('allUsers');
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print(
        'Background message: ${message.notification?.title ?? ''} - ${message.notification?.body ?? ''}');
  }

  void _showDialog(BuildContext context, String title, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }
}
