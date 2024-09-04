import 'dart:convert';

import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/error_modal.dart';
import 'package:fashion_app/src/auth/models/auth_token_model.dart';
import 'package:fashion_app/src/auth/models/profile_model.dart';
import 'package:fashion_app/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthNotifier with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  void setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  // Ham xu ly dang nhap va luu token vao storage => sau do dung ve home
  void loginFunc(String data, BuildContext context) async {
    // var url = Uri.parse('http://localhost:8000/auth/token/login/');
    var url = Uri.parse('${Environment.appBaseUrl}/auth/token/login/');
    setLoading();
    try {
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: data);
      if (response.statusCode == 200) {
        String accessToken = accessTokenModelFromJson(response.body).authToken;
        Storage().setString('accessToken', accessToken);

        getUser(accessToken, context);
        context.go('/home');
        setLoading();
      }
    } catch (e) {
      setLoading();
      showErrorPopup(context, AppText.kErrorLogin, null, null);
    }
  }

  // ham xu ly dang ki
  void registrationFunc(String data, BuildContext context) async {
    var url = Uri.parse('${Environment.appBaseUrl}/auth/users');
    setLoading();
    try {
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: data);
      if (response.statusCode == 201) {
        setLoading();
      } else if (response.statusCode == 400) {
        setLoading();
        var data = jsonDecode(response.body);
        showErrorPopup(context, data['password'][0], null, null);
      }
    } catch (e) {
      setLoading();
      showErrorPopup(context, AppText.kErrorLogin, null, null);
    }
  }

  // ham lay thong tin nguoi dung
  void getUser(String accessToken, BuildContext context) async {
    var url = Uri.parse('${Environment.appBaseUrl}/auth/users/me');
    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken'
        },
      );
      if (response.statusCode == 200) {
        Storage().setString('accessToken', accessToken);
        Storage().setString(accessToken, response.body);
        context.read<TabIndexNotifier>().setIndex(0);
        context.go('/home');
      }
    } catch (e) {
      showErrorPopup(context, AppText.kErrorLogin, null, null);
    }
  }

  // ham dang xuat
  void logoutFunc(BuildContext context) async {
    var url = Uri.parse('${Environment.appBaseUrl}/auth/token/logout/');
    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      setLoading();
      showErrorPopup(context, AppText.kErrorLogin, null, null);
    }
  }

  ProfileModel? getUserData() {
    String? accessToken = Storage().getString('accessToken');

    if (accessToken != null) {
      var data = Storage().getString(accessToken);
      if (data != null) {
        return profileModelFromJson(data);
      }
    }
  }
}
