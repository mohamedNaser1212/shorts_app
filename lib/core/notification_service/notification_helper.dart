import 'package:flutter/material.dart';
import 'package:shorts/core/notification_service/push_notification_service.dart';

abstract class NotificationHelper {
  const NotificationHelper();
  Future<String> getAccessToken();
  Future<void> sendNotificationToSpecificUser({
    required String fcmToken,
    required String userId,
    required String title,
    required String body,
    required BuildContext context,
  });
  void subscribeToAllUsersTopic();

  Future<void> initialize(NotificationCallback onMessageReceived);
}
