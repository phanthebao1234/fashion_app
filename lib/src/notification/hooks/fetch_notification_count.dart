import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:fashion_app/src/notification/controllers/notification_notifier.dart';
import 'package:fashion_app/src/notification/hooks/results/notification_count_result.dart';
import 'package:fashion_app/src/notification/models/notification_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

FetchNotificationCount fetchNotificationCount(BuildContext context) {
  final initialNotificationCount = NotificationCount(unreadCount: 0);
  final count = useState<NotificationCount>(initialNotificationCount);

  final isLoading = useState(false);

  final error = useState<String?>(null);

  final accessToken = Storage().getString('accessToken');

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/notification/count');

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken'
      });

      if (response.statusCode == 200) {
        count.value = notificationCountFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    if (accessToken != null) {
      fetchData();
    }
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  context.read<NotificationNotifier>().setRefetchCount(refetch);

  return FetchNotificationCount(
    count: count.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
