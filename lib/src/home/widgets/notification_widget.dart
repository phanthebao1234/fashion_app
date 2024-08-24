import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/login_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // GestureDetector là một widget trong Flutter cho phép nhận diện và phản hồi các cử chỉ chạm khác nhau, như chạm, vuốt, kéo và nhiều cử chỉ khác.
    // Widget này hoạt động bằng cách kiểm tra các callback không null để quyết định cử chỉ nào sẽ được nhận diện.
    // Nếu widget có một đứa trẻ, nó cũng sẽ hoạt động dựa trên nó.
    return GestureDetector(
      onTap: () {
        if (Storage().getString("accessToken") == null) {
          print("User not loggin");
          loginBottomSheet(context);
        } else {
          context.push("/notifications");
        }
      },
      child: Padding(
        padding: EdgeInsets.only(right: 13.w),
        child: CircleAvatar(
          backgroundColor: Kolors.kGray.withOpacity(.3),
          child: Badge(
            label: Text('4'),
            child: Icon(
              Ionicons.notifications,
              color: Kolors.kPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
