import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/src/notification/controllers/notification_notifier.dart';
import 'package:fashion_app/src/notification/hooks/results/notification_result.dart';
import 'package:fashion_app/src/notification/models/notification_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

FetchNotification fetchNotification(BuildContext context) {
  final notification = useState<List<NotificationModel>>([]);

  final isLoading = useState(false);

  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/notification/me');
      String? accessToken = Storage().getString('accessToken');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken'
        },
      );
      if (response.statusCode == 200) {
        notification.value = notificationModelFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }
  
  context.read<NotificationNotifier>().setRefetch(refetch);

  return FetchNotification(
    notification: notification.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
