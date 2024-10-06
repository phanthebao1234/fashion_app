import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationNotifier with ChangeNotifier {
  Function? refetchCount;

  void setRefetchCount(Function? r) {
    refetchCount = r;
  }

  Function? refetch;

  void setRefetch(Function? r) {
    refetch = r;
  }

  int _orderId = 0;

  int get orderId => _orderId;

  void setOrderId(int id) {
    _orderId = id;
    markAsRead(id);
    notifyListeners();
  }

  Future<void> markAsRead(int id) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/notification/update/?id=$id');
      final response = await http.patch(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken'
      });
      if (response.statusCode == 200) {
        refetch!();
        refetchCount!();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
