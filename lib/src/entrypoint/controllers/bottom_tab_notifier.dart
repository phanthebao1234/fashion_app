import 'package:flutter/material.dart';

/// Lớp TabIndexNotifier dùng để quản lý state của tab hiện tại.
/// Khi giá trị index thay đổi, tất cả widget lắng nghe sự kiện thay đổi này sẽ được cập nhật giao diện.
class TabIndexNotifier with ChangeNotifier {
  int _index = 0;
  int get index => _index;
  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
