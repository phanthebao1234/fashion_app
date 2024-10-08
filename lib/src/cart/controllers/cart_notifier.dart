// ignore_for_file: prefer_final_fields, collection_methods_unrelated_type

import 'dart:convert';

import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:fashion_app/src/cart/models/cart_model.dart';
import 'package:fashion_app/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:fashion_app/src/products/controllers/colors_sizes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartNotifier with ChangeNotifier {
  Function? refetchCount;

  void setRefetchCount(Function? r) {
    refetchCount = r;
  }

  // Đây là định nghĩa một lớp tên là CartNotifier sử dụng mixin ChangeNotifier.
  // ChangeNotifier là một lớp do Flutter cung cấp giúp quản lý trạng thái và thông báo cho các listener khi có sự thay đổi
  int _qty =
      0; // Một biến số nguyên private được khởi tạo bằng 0, đại diện cho số lượng mặt hàng trong giỏ hàng.
  int get qty =>
      _qty; // Đây là các phương thức getter cho phép các phần khác của mã truy cập vào các biến private

  // Phương thức này tăng _qty lên 1 và sau đó gọi notifyListeners(), thông báo cho tất cả các listener rằng trạng thái đã thay đổi.
  void increment() {
    _qty++;
    notifyListeners();
  }

  // Phương thức này giảm _qty xuống 1 và chỉ khi _qty lớn hơn 1 sau đó gọi notifyListeners(), thông báo cho tất cả các listener rằng trạng thái đã thay đổi.
  void decrement() {
    if (_qty > 1) {
      _qty--;
      notifyListeners();
    }
  }

  int?
      _selectedCart; // Một biến số nguyên có thể null private giữ ID của giỏ hàng được chọn.

  int? get selectedCart =>
      _selectedCart; // Đây là các phương thức getter cho phép các phần khác của mã truy cập vào các biến private

  // Phương thức Đặt Bộ đếm Đã chọn
  // Phương thức này đặt _selectedCart thành id được cung cấp và _qty thành q được cung cấp, sau đó gọi notifyListeners()
  void setSelectedCounter(int id, int q) {
    _selectedCart = id;
    _qty = q;
    notifyListeners();
  }

  // Phương thức Xóa Đã chọn
  // Phương thức này xóa giỏ hàng đã chọn bằng cách đặt _selectedCart thành null và _qty thành 0, sau đó gọi notifyListeners().
  void clearSelected() {
    _selectedCart = null;
    _qty = 0;
    _selectedCartItems.clear;
    _selectedCartItemsId.clear;
    notifyListeners();
  }

  Future<void> deleteCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/delete/?id=$id');
      final response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken'
      });
      if (response.statusCode == 204) {
        refetchCount!();
        refetch();
        clearSelected();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/cart/update/?id=$id&count=$_qty');
      final response = await http.patch(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken'
      });
      if (response.statusCode == 200) {
        refetch();
        clearSelected();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addToCart(String data, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/add/');
      final response = await http.post(
        url,
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken'
        },
      );
      if (response.statusCode == 201) {
        // refetch count
        refetchCount!();

        context.read<ColorsSizesNotifier>().setSizes('');
        context.read<ColorsSizesNotifier>().setColors('');

        // navigate to the cart
        context.read<TabIndexNotifier>().setIndex(3);
        context.go('/home');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<int> _selectedCartItemsId = [];

  List<int> get selectedCartItemsId => _selectedCartItemsId;

  List<CartModel> _selectedCartItems = [];

  List<CartModel> get selectedCartItems => _selectedCartItems;

  double totalPrice = 0.0;

  void selectOrDeselect(int id, CartModel cartItem) {
    if (_selectedCartItemsId.contains(id)) {
      _selectedCartItemsId.remove(id);
      _selectedCartItems.removeWhere((i) => i.id == id);
      totalPrice = calculateTotalPrice(_selectedCartItems);
    } else {
      _selectedCartItemsId.add(id);
      _selectedCartItems.add(cartItem);
      totalPrice = calculateTotalPrice(_selectedCartItems);
    }
    notifyListeners();
  }

  double calculateTotalPrice(List<CartModel> items) {
    double total = 0.0;
    for (var item in items) {
      total += item.quantity * item.product.price;
    }
    return total;
  }

  String _paymentUrl = '';
  String get paymentUrl => _paymentUrl;
  void setPaymentUrl(String url) {
    _paymentUrl = url;
    notifyListeners();
  }

  String _success = '';
  String get success => _success;
  void setSuccessUrl(String url) {
    _success = url;
    notifyListeners();
  }

  void createCheckout(String data) async {
    print(data);
    try {
      Uri url = Uri.parse(
          "${Environment.paymentBaseUrl}/stripe/create-checkout-session");

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: data);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setPaymentUrl(responseData['url']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
