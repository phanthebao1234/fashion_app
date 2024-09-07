import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/src/home/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Trong Flutter, "elevation" là thuộc tính xác định độ cao của widget, ảnh hưởng đến hiệu ứng bóng đổ bên dưới nó.
      elevation: 0,
      //  Khi thuộc tính này được thiết lập là true và không có widget dẫn đầu (leading) nào được cung cấp,
      // nó sẽ tự động cố gắng suy đoán widget nào nên làm widget dẫn đầu. Nếu thuộc tính được thiết lập là false,
      // nó sẽ không thực hiện hành động tự động nào cho widget dẫn đầu.
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReusableText(
            text: "Location",
            style: appStyle(12, Kolors.kGray, FontWeight.normal),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Icon(
                Ionicons.location,
                size: 16,
                color: Kolors.kPrimary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: SizedBox(
                  width: ScreenUtil().screenWidth * 0.7,
                  child: Text(
                    "Please select a location",
                    style: appStyle(
                      12,
                      Kolors.kDark,
                      FontWeight.w500,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: const [
        // Padding(
        //   padding: const EdgeInsets.only(right: 6.0),
        //   child: Icon(
        //     Icons.search,
        //     color: Colors.black,
        //   ),
        // ),
        NotificationWidget(),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: GestureDetector(
          onTap: () {
            context.push('/search');
          },
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: Container(
                      height: 40.h,
                      width: ScreenUtil().screenWidth - 80,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5, color: Kolors.kGrayLight),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 6.0, right: 6.0),
                              child: Icon(
                                Ionicons.search,
                                size: 20,
                                color: Kolors.kPrimaryLight,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            ReusableText(
                              text: "Search Products",
                              style: appStyle(
                                14,
                                Kolors.kGray,
                                FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Kolors.kPrimary,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Icon(
                      FontAwesome.sliders,
                      size: 20,
                      color: Kolors.kWhite,
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
