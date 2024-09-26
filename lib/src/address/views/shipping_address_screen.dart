import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/back_button.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/src/address/controllers/address_notifier.dart';
import 'package:fashion_app/src/address/hooks/fetch_address_list.dart';
import 'package:fashion_app/src/address/widgets/address_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressesListPage extends HookWidget {
  const AddressesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchAddress();
    final address = results.address;
    final isLoading = results.isLoading;
    final refetch = results.refetch;

    if (isLoading) {
      return const Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: ListShimmer(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: ReusableText(
            text: AppText.kAddresses,
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: List.generate(address.length, (i) {
          return AddressTile(
            onDelete: () {
              context
                  .read<AddressNotifier>()
                  .deleteAddress(address[i].id, refetch, context);
            },
            address: address[i],
            isCheckout: false,
            setDefault: () {
              context
                  .read<AddressNotifier>()
                  .setAsDefault(address[i].id, refetch, context);
            },
          );
        }),
      ),
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
