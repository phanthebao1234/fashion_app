import 'package:flutter/material.dart';

class CategoryNotifier with ChangeNotifier {
  // biến nguyên lưu trữ giá trị ID 
  int _id = 0;
  
  // chuỗi category lưu giá trị chỉ mục (index)
  String category = "";
  
  // getter để truy cập giá trị của _id
  int get id => _id;
  
  // phương thức này cập nhật giá trị của category và gọi notifyListeners() để
  // thông báo cho các widget lắng nghe rằng trạng thái đã thay đổi
  void setCategory(String c, int id) {
    category = c;
    _id = id;
    notifyListeners();  
  }

}
