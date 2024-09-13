import 'dart:convert';

import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WishlistNotifier with ChangeNotifier {
  String? error;
  void setError(String e) {
    error = e;
    notifyListeners();
  }

  void addRemoveWishList(int id, Function refetch) async {
    final String? accessToken = Storage().getString('accessToken');

    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/wishlist/toggle/?id=$id');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken'
        },
      );

      print(response.statusCode);
      if (response.statusCode == 201) {
        // SET THE ID TO A LIST IN OUR LOCAL STORAGE
        setToList(id);
        refetch();
        // REFETCH DATA
      } else if (response.statusCode == 204) {
        // REMOVE FROM LOCAL STORAGE
        setToList(id);
        refetch();
        // REFETCH DATA
      }
    } catch (e) {
      error = e.toString();
    }
  }

  List _wishlist = [];

  List get wishlist => _wishlist;

  void setWishList(List w) {
    _wishlist.clear();
    _wishlist = w;
    notifyListeners();
  }

  void setToList(int v) {
    String? accessToken = Storage().getString('accessToken');

    String? wishlist = Storage().getString('${accessToken}wishlist');

    try {
      if (wishlist == null) {
        List wishlist = [];
        wishlist.add(v);
        setWishList(wishlist);
        Storage().setString('${accessToken}wishlist', jsonEncode(wishlist));
      } else {
        List w = jsonDecode(wishlist);

        if (w.contains(v)) {
          w.removeWhere((e) => e == v);
        } else if (!w.contains(v)) {
          w.add(v);
        }
        setWishList(w);
        Storage().setString('${accessToken}wishlist', jsonEncode(w));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
