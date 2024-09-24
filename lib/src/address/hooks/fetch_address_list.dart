import 'dart:convert';

import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/src/address/hooks/results/address_list_results.dart';
import 'package:fashion_app/src/address/models/address_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:http/http.dart' as http;

FetchAddress fetchAddress() {
  final address = useState<List<AddressModel>>([]);

  final isLoading = useState(false);

  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/address/list');
      String? accessToken = Storage().getString('accessToken');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken'
        },
      );
      if (response.statusCode == 200) {
        address.value = addressListModelFromJson(utf8.decode(response.bodyBytes));
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

  return FetchAddress(
    address: address.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
