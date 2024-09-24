import 'dart:convert';

import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/src/address/hooks/results/default_results.dart';
import 'package:fashion_app/src/address/models/address_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:http/http.dart' as http;

FetchDefaultAddress fetchDefaultAddress() {
  final address = useState<AddressModel?>(null);

  final isLoading = useState(false);

  final error = useState<String?>(null);

  String? accessToken = Storage().getString('accessToken');

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/address/default/');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken'
        },
      );
      if (response.statusCode == 200) {
        // sử dụng utf8.decode(response.bodyBytes) để sử dụng tiếng Việt ko bị lỗi thay cho response.body
        // final decodedResponse = utf8.decode(response.bodyBytes);
        address.value = addressModelFromJson(utf8.decode(response.bodyBytes));
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

  return FetchDefaultAddress(
    address: address.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
