import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:fashion_app/src/cart/models/cart_model.dart';
import 'package:fashion_app/src/cart/widgets/cart_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CheckoutTile extends StatelessWidget {
  const CheckoutTile({super.key, required this.cart});

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Container(
              width: ScreenUtil().screenWidth,
              height: 90.h,
              decoration: BoxDecoration(
                color: !cartNotifier.selectedCartItemsId.contains(cart.id)
                    ? Kolors.kWhite
                    : Kolors.kPrimaryLight.withOpacity(.2),
                borderRadius: kRadiusAll,
              ),
              child: SizedBox(
                height: 85.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Kolors.kWhite,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                topRight: Radius.circular(12),
                              )),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: kRadiusAll,
                                child: SizedBox(
                                  width: 76.w,
                                  height: double.infinity,
                                  child: CachedNetworkImage(
                                    imageUrl: cart.product.imageUrls[0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: cart.product.title,
                              style:
                                  appStyle(14, Kolors.kDark, FontWeight.w500),
                            ),
                            ReusableText(
                              text: 'Size: ${cart.size}',
                              style:
                                  appStyle(10, Kolors.kDark, FontWeight.normal),
                            ),
                            ReusableText(
                              text: 'Color: ${cart.color}',
                              style:
                                  appStyle(10, Kolors.kDark, FontWeight.normal),
                            ),
                            SizedBox(
                              width: ScreenUtil().screenWidth * .5.w,
                              child: Text(
                                'Description: ${cart.product.description}',
                                maxLines: 2,
                                style: appStyle(
                                    10, Kolors.kPrimary, FontWeight.normal),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          cartNotifier.selectedCart != null &&
                                  cartNotifier.selectedCart == cart.id
                              ? const CartCounter()
                              : GestureDetector(
                                  onTap: () {
                                    context
                                        .read<CartNotifier>()
                                        .setSelectedCounter(
                                            cart.id, cart.quantity);
                                  },
                                  child: Container(
                                    width: 40.w,
                                    height: 20.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Kolors.kPrimary,
                                          width: .5,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    child: ReusableText(
                                      text: '* ${cart.quantity}',
                                      style: appStyle(
                                          12, Kolors.kDark, FontWeight.normal),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 6),
                            child: ReusableText(
                                text:
                                    '\$ ${(cart.quantity * cart.product.price).toStringAsFixed(2)}',
                                style: appStyle(
                                    12, Kolors.kDark, FontWeight.w600)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
