import 'package:fashion_app/common/services/storage.dart';
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
import 'package:fashion_app/src/checkout/models/check_out_model.dart';
import 'package:fashion_app/src/checkout/views/payment.dart';
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

    return context
            .watch<CartNotifier>()
            .paymentUrl
            .contains('https://checkout.stripe.com')
        ? const PaymentWebView()
        : Scaffold(
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
                onTap: () {
                  if (address == null) {
                    print('run if');
                    context.push('addresses');
                  } else {
                    print('run eles');
                    String? accessToken = Storage().getString("accessToken");
                    List<CartItem> checkoutItems = [];

                    for (var item in cartNotifier.selectedCartItems) {
                      CartItem data = CartItem(
                          name: item.product.title,
                          id: item.product.id,
                          price: item.product.price.roundToDouble(),
                          size: item.size,
                          color: item.color,
                          cartQuantity: item.quantity);

                      checkoutItems.add(data);
                    }

                    CreateCheckout data = CreateCheckout(
                        address: context.read<AddressNotifier>().address == null
                            ? address.id
                            : context.read<AddressNotifier>().address!.id,
                        accesstoken: accessToken.toString(),
                        fcm: '',
                        totalAmount: cartNotifier.totalPrice,
                        cartItems: checkoutItems);
                    String c = createCheckoutToJson(data);
                    cartNotifier.createCheckout(c);
                  }
                },
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
