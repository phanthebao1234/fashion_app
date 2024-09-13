import 'package:fashion_app/common/utils/enums.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:fashion_app/src/products/hooks/results/products_result.dart';
import 'package:fashion_app/src/products/models/products_models.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchProducts fetchProducts(QueryType queryType) {
  final products = useState<List<Products>>([]);

  final isLoading = useState(false);

  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    Uri url;
    try {
      switch (queryType) {
        case QueryType.all:
          url = Uri.parse('${Environment.appBaseUrl}/api/product/');
          break;
        case QueryType.popular:
          url = Uri.parse('${Environment.appBaseUrl}/api/product/popular');
          break;
        case QueryType.unisex:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/product/byType/?clothesType=${queryType.name}');
          break;
        case QueryType.men:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/product/byType/?clothesType=${queryType.name}');
          break;
        case QueryType.women:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/product/byType/?clothesType=${queryType.name}');
          break;
        case QueryType.kids:
          url = Uri.parse(
              '${Environment.appBaseUrl}/api/product/byType/?clothesType=${queryType.name}');
          break;
      }
      final response = await http.get(url);
      if (response.statusCode == 200) {
        products.value = productsFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  
  // Sử dụng useEffect khi có thay đổi dữ liệu như Tab ở trang home khi query type nó thay đổi thì nó sẽ refetch dữ liệu lại
  useEffect(() {
    fetchData();
    return;
  }, [queryType.index]);

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
