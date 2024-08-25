import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/custom_button.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeSlilder extends StatelessWidget {
  const HomeSlilder({super.key});

  @override
  Widget build(BuildContext context) {
    // ClipRRect trong Flutter là một widget dùng để cắt một widget con theo hình chữ nhật có các góc bo tròn.
    return ClipRRect(
      borderRadius: kRadiusAll,
      child: Stack(
        children: [
          SizedBox(
            height: ScreenUtil().screenHeight * 0.16,
            width: ScreenUtil().screenWidth,
            child: ImageSlideshow(
              indicatorColor: Kolors.kPrimaryLight,
              indicatorRadius: 3,
              onPageChanged: (p) {},
              autoPlayInterval: 3000, // seconds
              isLoop: true,
              children: List.generate(images.length, (i) {
                return CachedNetworkImage(
                  // CachedNetworkImage là một thư viện Flutter dùng để tải và lưu trữ hình ảnh từ mạng.
                  // Nó hỗ trợ việc sử dụng hình ảnh với các widget placeholder và error,
                  // và có thể được sử dụng trực tiếp hoặc thông qua ImageProvider.
                  placeholder: placeholder,
                  errorWidget: errorWidget,
                  imageUrl: images[i],
                  fadeInDuration: Duration(milliseconds: 2500),
                  fit: BoxFit.cover,
                );
              }),
            ),
          ),
          Positioned(
              child: SizedBox(
            height: ScreenUtil().screenHeight * 0.16,
            width: ScreenUtil().screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableText(
                    text: AppText.kCollection,
                    style: appStyle(20, Kolors.kDark, FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Discount 50% off \nthe first transaction",
                    style: appStyle(
                      14,
                      Kolors.kDark.withOpacity(.6),
                      FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                    text: "Shop now",
                    btnWidth: 150.w,
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

List<String> images = [
  "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3",
  "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3",
  "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3",
  "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3",
  "https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3",
];
