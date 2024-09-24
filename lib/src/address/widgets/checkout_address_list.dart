import 'package:fashion_app/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashion_app/src/address/hooks/fetch_address_list.dart';
import 'package:fashion_app/src/address/widgets/select_address_tile.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutAddressList extends HookWidget {
  const CheckoutAddressList({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchAddress();
    final addressess = results.address;
    final isLoading = results.isLoading;

    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: const ListShimmer(),
      );
    }

    return ListView(
      children: List.generate(addressess.length, (i) {
        return SelectAddressTile(address: addressess[i]);
      }),
    );
  }
}
