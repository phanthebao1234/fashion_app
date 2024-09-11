import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/src/products/hooks/results/products_result.dart';
import 'package:fashion_app/src/products/models/products_models.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:http/http.dart' as http;

FetchProducts fetchWishList() {
  final products = useState<List<Products>>([]);

  final isLoading = useState(false);

  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/wishlist/me');
      print(url);
      String? accessToken = Storage().getString('accessToken');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken'
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        products.value = productsFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
      print(e.toString());
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

  return FetchProducts(
    products: products.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
