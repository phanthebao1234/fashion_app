
import 'package:fashion_app/src/notification/models/notification_count.dart';
import 'package:flutter/material.dart';

class FetchNotificationCount {
  final NotificationCount count;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchNotificationCount({
    required this.count,
    required this.isLoading,
    required this.error,
    required this.refetch, 
  });
}
