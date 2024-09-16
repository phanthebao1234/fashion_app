import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashion_app/src/auth/views/login_screen.dart';
import 'package:fashion_app/src/cart/hooks/fetch_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends HookWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchCart();
    final cart = results.cart;
    final isLoading = results.isLoading;
    final error = results.error;
    final refetch = results.refetch;

    String? accessToken = Storage().getString('accessToken');

    if (accessToken == null) {
      return const LoginPage();
    }

    if (isLoading) {
      return Scaffold(
        body: const ListShimmer(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: AppText.kCart,
          style: appStyle(15, Kolors.kPrimary, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
          children: List.generate(cart.length, (i) {
        return Container(
          width: ScreenUtil().screenWidth,
          height: 100,
          color: Kolors.kPrimary,
        );
      })),
    );
  }
}
