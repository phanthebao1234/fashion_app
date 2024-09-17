import 'package:flutter/material.dart';

class CartNotifier with ChangeNotifier {
  int _qty = 0;

  int get qty => _qty;

  void increment() {
    _qty++;
    notifyListeners();
  }

  void decrement() {
    if (_qty > 1) {
      _qty--;
      notifyListeners();
    }
  }

  int? _selectedCart;

  int? get selectedCart => _selectedCart;

  void setSelectedCounter(int id, int q) {
    _selectedCart = id;
    _qty = q;
  }
}
