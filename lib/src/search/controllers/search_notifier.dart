import 'package:fashion_app/common/utils/environment.dart';
import 'package:fashion_app/src/products/models/products_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchNotifier with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Products> _results = [];

  List<Products> get results => _results;

  void setResults(List<Products> value) {
    _results = value;
    notifyListeners();
  }

  void clearResults() {
    _results = [];
  }

  String _currentQuery = '';

  String get currentQuery => _currentQuery;

  void setCurrentQuery(String value) {
    _currentQuery = value;
    notifyListeners();
  }

  String? _error = '';

  String? get error => _error;

  void setError(String value) {
    _error = value;
    notifyListeners();
  }

  String _searchKey = '';

  String get searchKey => _searchKey;

  void setSearchKey(String value) {
    _searchKey = value;
    notifyListeners();
  }

  void searchFunction(String searchKey) async {
    setIsLoading(true);
    setSearchKey(searchKey);

    Uri url =
        Uri.parse('${Environment.appBaseUrl}/api/product/search?q=$searchKey');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = productsFromJson(response.body);
        setResults(data);
        setIsLoading(true);
      }
    } catch (e) {
      setError(e.toString());
      setIsLoading(false);
    }
  }
}
