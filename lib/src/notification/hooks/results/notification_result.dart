import 'package:fashion_app/src/notification/models/notification_model.dart';
import 'package:flutter/material.dart';

class FetchNotification {
  final List<NotificationModel> notification;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchNotification({
    required this.notification,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
