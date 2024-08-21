import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/custom_button.dart';
import 'package:fashion_app/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Kolors.kWhite,
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
              Image.asset(
                R.ASSETS_IMAGES_GETSTARTED_PNG,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(AppText.kWelcomeHeader,
                  style: appStyle(24, Kolors.kPrimary, FontWeight.bold)),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: ScreenUtil().screenWidth - 100,
                child: Text(
                  AppText.kWelcomeMessage,
                  textAlign: TextAlign.center,
                  style: appStyle(11, Kolors.kGray, FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GradientBtn(
                text: AppText.kGetStarted,
                onTap: () {},
                btnHeight: 50,
                radius: 20,
                btnWidth: ScreenUtil().screenWidth - 100,
              )
            ],
          )),
    );
  }
}
