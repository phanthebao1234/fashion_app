import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/src/orders/hooks/results/orders_results.dart';
import 'package:fashion_app/src/orders/models/order_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:http/http.dart' as http;

FetchOrders fetchOrders(int id) {
  final order = useState<List<OrdersModel?>>([]);

  final isLoading = useState(false);

  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/orders/single/?order_id=$id');
      String? accessToken = Storage().getString('accessToken');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken'
        },
      );
      if (response.statusCode == 200) {
        order.value = ordersListModelFromJson(response.body);
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

  return FetchOrders(
    order: order.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
