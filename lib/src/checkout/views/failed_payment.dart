import 'package:fashion_app/common/utils/enums.dart';
import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/packages_exports.dart';
import 'package:fashion_app/common/utils/providers_exports.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/const/resource.dart';
import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FailedPayment extends StatelessWidget {
  const FailedPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar không có nút quay lại (automaticallyImplyLeading: false).
        automaticallyImplyLeading: false,
        // Tiêu đề của AppBar là “Payment”, được định dạng bằng widget ReusableText với kiểu chữ được định nghĩa bởi hàm appStyle.
        title: ReusableText(
            text: "Payment",
            style: appStyle(16, Kolors.kPrimary, FontWeight.w600)),
      ),
      body: Column(
        // Column chứa các widget con được căn giữa theo cả chiều dọc và chiều ngang.
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            // Image.asset hiển thị hình ảnh thất bại từ tài nguyên.
            child: Image.asset(
              R.ASSETS_IMAGES_FAILED_PNG,
              width: 250.w,
              height: 250.h,
            ),
          ),
          Center(
            // ReusableText hiển thị thông báo “Payment Failed!” và “Oops! Payment Failed! Please Try Again” với các kiểu chữ khác nhau.
              child: ReusableText(
            text: 'Payment Failed!',
            style: appStyle(20, Kolors.kPrimary, FontWeight.w600),
          )),
          SizedBox(
            // SizedBox tạo khoảng cách giữa các phần tử.
            height: 10.h,
          ),
          Center(
              child: ReusableText(
            text: 'Oops! Payment Failed! Please Try Again',
            style: appStyle(14, Kolors.kGray, FontWeight.normal),
          ))
        ],
      ),
      bottomNavigationBar: GestureDetector(
        // GestureDetector lắng nghe sự kiện chạm để thực hiện hành động khi người dùng nhấn vào.
        onTap: () {
          context.read<CartNotifier>().setPaymentUrl('');
          // context
          //     .read<NotificationNotifier>()
          //     .setReloadCount(NotificationCount.update);
          // Khi nhấn vào, CartNotifier được cập nhật để đặt lại URL thanh toán và điều hướng người dùng về trang chủ
          context.go('/home');
        },
        child: Container(
          // Container chứa văn bản “Continue to Home” được định dạng bằng ReusableText.
          height: 80,
          width: ScreenUtil().screenWidth,
          decoration:
              BoxDecoration(color: Kolors.kPrimary, borderRadius: kRadiusTop),
          child: Center(
            child: ReusableText(
                text: "Continue to Home",
                style: appStyle(16, Kolors.kWhite, FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
