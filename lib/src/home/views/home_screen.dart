import 'package:fashion_app/src/home/widgets/custom_app_bar.dart';
import 'package:fashion_app/src/home/widgets/home_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          // PreferredSize trong Flutter là một widget tùy chỉnh cho phép bạn xác định kích thước ước lượng mà thanh app bar của bạn mong muốn.
          preferredSize: Size.fromHeight(110),
          child: CustomAppBar()),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: [
          SizedBox(
            height: 20.h,
          ),
          HomeSlilder(),
        ],
      ),
    );
  }
}
