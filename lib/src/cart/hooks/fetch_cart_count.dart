import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:fashion_app/src/cart/hooks/results/cart_count_results.dart';
import 'package:fashion_app/src/cart/models/cart_count_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchCartCount fetchCartCount() {
  final initialCartCount = CartCountModel(cartCount: 0);
  final count = useState<CartCountModel>(initialCartCount);

  final isLoading = useState(false);

  final error = useState<String?>(null);

  final accessToken = Storage().getString('accessToken');

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/me');

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken'
      });

      if (response.statusCode == 200) {
        count.value = cartCountModelFromJson(response.body);
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

  return FetchCartCount(
    count: count.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
