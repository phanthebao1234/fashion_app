
import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/const/resource.dart';
import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SuccessfulPayment extends StatelessWidget {
  const SuccessfulPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar không có nút quay lại (automaticallyImplyLeading: false).
        automaticallyImplyLeading: false,
        // Tiêu đề của AppBar là “Payment”, được định dạng bằng widget ReusableText với kiểu chữ được định nghĩa bởi hàm appStyle
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
            // Image.asset hiển thị hình ảnh thành công từ tài nguyên.
            child: Image.asset(
              R.ASSETS_IMAGES_CHECKOUT_PNG,
              width: 250.w,
              height: 250.h,
            ),
          ),
          Center(
            // ReusableText hiển thị thông báo “Payment Successful!” và “Thank you for your purchase” với các kiểu chữ khác nhau.
              child: ReusableText(
            text: 'Payment Successful!',
            style: appStyle(20, Kolors.kPrimary, FontWeight.w600),
          )),
          SizedBox(
            // SizedBox tạo khoảng cách giữa các phần tử.
            height: 10.h,
          ),
          Center(
              child: ReusableText(
            text: 'Thank you for your purchase',
            style: appStyle(14, Kolors.kGray, FontWeight.normal),
          ))
        ],
      ),
      bottomNavigationBar: GestureDetector(
        // GestureDetector lắng nghe sự kiện chạm để thực hiện hành động khi người dùng nhấn vào.
        onTap: () {
          // Khi nhấn vào, CartNotifier được cập nhật để đặt lại URL thanh toán và điều hướng người dùng về trang chủ (context.go('/home')).
          context.read<CartNotifier>().setPaymentUrl('');
          // context
          //     .read<NotificationNotifier>()
          //     .setReloadCount(NotificationCount.update);
          context.go('/home');
        },
        child: Container(
          height: 80,
          width: ScreenUtil().screenWidth,
          decoration:
              BoxDecoration(color: Kolors.kPrimary, borderRadius: kRadiusTop),
          child: Center(
            child: ReusableText(
              // Container chứa văn bản “Continue to Home” được định dạng bằng ReusableText.
                text: "Continue to Home",
                style: appStyle(16, Kolors.kWhite, FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
