import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartNotifier with ChangeNotifier {
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
    notifyListeners();
  }

  Future<void> deleteCart() async {}

  Future<void> updateCart(int id, void Function() refetch) async {
    print('run here');
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
}
