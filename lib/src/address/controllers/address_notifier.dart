import 'package:fashion_app/common/models/api_error_model.dart';
import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:fashion_app/common/widgets/error_modal.dart';
import 'package:fashion_app/src/address/models/address_model.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class AddressNotifier with ChangeNotifier {
  Function refetchA = () {};
  void setRefetch(Function r) {
    refetchA = r;
  }

  AddressModel? address;

  void setAddress(AddressModel ad) {
    address = ad;
    notifyListeners();
  }

  void clearAddress() {
    address = null;
    notifyListeners();
  }

  List<String> addressTypes = ['Home', 'Office', 'School'];

  String _addressType = '';

  void setAddressType(String type) {
    _addressType = type;
    notifyListeners();
  }

  String get addressType => _addressType;

  void clearAddressType() {
    _addressType = '';
  }

  bool _defaultToggle = false;

  void setDefaultToggle(bool d) {
    _defaultToggle = d;
    notifyListeners();
  }

  bool get defaultToggle => _defaultToggle;

  void clearDefaultToggle() {
    _defaultToggle = false;
  }

  void setAsDefault(int id, Function refetch, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/address/default/?id=$id');
      final response = await http.patch(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken',
      });
      if (response.statusCode == 200) {
        refetch();
      } else if (response.statusCode == 401 || response.statusCode == 500) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(context, data.message, "Error Changing address", true);
        print("Error: $data");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteAddress(int id, Function refetch, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/address/delete/?id=$id');
      final response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken',
      });
      if (response.statusCode == 204) {
        refetch();
      } else if (response.statusCode == 401 || response.statusCode == 500) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(context, data.message, "Error delete address", true);
        print("Error: $data");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void addAddress(String data, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/address/add/');
      final response = await http.post(
        url,
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      if (response.statusCode == 201) {
        refetchA();
        context.pop();
      }
    } catch (e) {
      debugPrint(e.toString());
      showErrorPopup(context, e.toString(), "Error add address", true);
    }
  }
}
