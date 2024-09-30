
import 'package:fashion_app/src/address/controllers/address_notifier.dart';
import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:fashion_app/src/checkout/views/failed_payment.dart';
import 'package:fashion_app/src/checkout/views/successful_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart' as webview_flutter;
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// Định nghĩa PaymentWebView widget
// PaymentWebView là một StatefulWidget, nghĩa là nó có thể thay đổi trạng thái trong quá trình sử dụng.
class PaymentWebView extends StatefulWidget {
  const PaymentWebView({super.key});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}
// ----------------------------------------------------------------

// Định nghĩa _PaymentWebViewState
// Phần này khởi tạo trạng thái của widget và lấy CartNotifier từ Provider 
class _PaymentWebViewState extends State<PaymentWebView> {
  late final webview_flutter.WebViewController _controller;

  @override
  void initState() {
    final cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    super.initState();
// ----------------------------------------------------------------

// Khởi tạo WebViewController
// Phần này khởi tạo các tham số cho WebViewController dựa trên nền tảng (iOS hoặc Android).
    late final webview_flutter.PlatformWebViewControllerCreationParams params;
    if (webview_flutter.WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const webview_flutter.PlatformWebViewControllerCreationParams();
    }

    final webview_flutter.WebViewController controller =
        webview_flutter.WebViewController.fromPlatformCreationParams(params);
// ----------------------------------------------------------------

// Cấu hình WebViewController
// Phần này cấu hình WebViewController để hỗ trợ JavaScript, đặt màu nền, và thiết lập các delegate để xử lý các sự kiện điều hướng và thay đổi URL.
    controller
      ..setJavaScriptMode(webview_flutter.JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        webview_flutter.NavigationDelegate(
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            cartNotifier.setSuccessUrl(url);
          },
          onNavigationRequest: (webview_flutter.NavigationRequest request) {
            return webview_flutter.NavigationDecision.navigate;
          },
          onUrlChange: (webview_flutter.UrlChange change) {
            cartNotifier.setSuccessUrl(change.url.toString());
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (webview_flutter.JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(context.read<CartNotifier>().paymentUrl));
// ----------------------------------------------------------------

    // #docregion platform_features
    
    // Cấu hình đặc biệt cho Android
    // Phần này bật chế độ gỡ lỗi và cho phép phát lại media mà không cần cử chỉ người dùng trên Android.
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features
    // ----------------------------------------------------------------

    _controller = controller;
  }

// Xây dựng giao diện người dùng
// Phần này xây dựng giao diện người dùng, hiển thị SuccessfulPayment hoặc FailedPayment dựa trên trạng thái của CartNotifier. 
// Nếu không, nó sẽ hiển thị WebViewWidget với WebViewController đã cấu hình
  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        if (cartNotifier.success.contains('checkout-success')) {
          context.read<AddressNotifier>().clearAddress();
          return const SuccessfulPayment();
        } else if (cartNotifier.success.contains('cancel')) {
          context.read<AddressNotifier>().clearAddress();
          return const FailedPayment();
        }

        return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.only(top: 60.h),
              child: webview_flutter.WebViewWidget(controller: _controller),
            ));
      },
    );
  }
}
