import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/back_button.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/src/address/controllers/address_notifier.dart';
import 'package:fashion_app/src/address/hooks/fetch_default.dart';
import 'package:fashion_app/src/address/widgets/address_block.dart';
import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:fashion_app/src/checkout/widgets/checkout_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends HookWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchDefaultAddress();
    final address = result.address;
    final isLoading = result.isLoading;

    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            // clear the address
            context.read<AddressNotifier>().clearAddress(); 
            context.pop();
          },
        ),
        title: ReusableText(
          text: AppText.kCheckout,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
        backgroundColor: Kolors.kWhite,
        centerTitle: true,
      ),
      body: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            children: [
              // add address block
              isLoading
                  ? const SizedBox.shrink()
                  : AddressBlock(
                      address: address,
                    ),

              SizedBox(
                height: 10.h,
              ),

              SizedBox(
                height: ScreenUtil().screenHeight * 0.5,
                child: Column(
                  children: List.generate(
                    cartNotifier.selectedCartItems.length,
                    (i) {
                      return CheckoutTile(
                          cart: cartNotifier.selectedCartItems[i]);
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
      bottomNavigationBar:
          Consumer<CartNotifier>(builder: (context, cartNotifier, child) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            height: 60,
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
                color: Kolors.kPrimaryLight, borderRadius: kRadiusTop),
            child: Center(
              child: ReusableText(
                  text: address == null
                      ? "Please an address"
                      : "Click to Payment",
                  style: appStyle(16, Kolors.kWhite, FontWeight.w600)),
            ),
          ),
        );
      }),
    );
  }
}
