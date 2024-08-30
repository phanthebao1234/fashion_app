import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/src/products/controllers/colors_sizes_notifier.dart';
import 'package:fashion_app/src/products/controllers/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ColorSelectionWidget extends StatelessWidget {
  const ColorSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ColorsSizesNotifier>(
        builder: (BuildContext context, ColorsSizesNotifier controller,
            Widget? child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                context.read<ProductNotifier>().product!.colors.length, (i) {
              String c = context.read<ProductNotifier>().product!.colors[i];
              return GestureDetector(
                onTap: () {
                  controller.setColors(c);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      right: 20.w, left: 20.w), // đối xứng ngang
                  margin: EdgeInsets.only(right: 20.w),
                  decoration: BoxDecoration(
                    borderRadius: kRadiusAll,
                    color: c == controller.colors
                        ? Kolors.kPrimary
                        : Kolors.kGrayLight,
                  ),
                  child: ReusableText(
                    text: c,
                    style: appStyle(12, Kolors.kWhite, FontWeight.normal),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
