import 'package:flutter/material.dart';

class NotificationNotifier with ChangeNotifier {
  Function? refetchCount;

  void setRefetchCount(Function? r) {
    refetchCount = r;
  }
}