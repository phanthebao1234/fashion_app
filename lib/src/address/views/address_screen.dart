import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressPage extends HookWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          // navigate to add address
        },
        child: Container(
          height: 60,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
              color: Kolors.kPrimaryLight, borderRadius: kRadiusTop),
          child: Center(
            child: ReusableText(
                text: "Add Address",
                style: appStyle(16, Kolors.kWhite, FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
