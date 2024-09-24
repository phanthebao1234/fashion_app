import 'package:fashion_app/src/address/models/address_model.dart';
import 'package:flutter/widgets.dart';

class AddressNotifier with ChangeNotifier {
  AddressModel? address;

  void setAddress(AddressModel ad) {
    address = ad;
    notifyListeners();
  }
}
