import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/src/address/models/address_model.dart';
import 'package:fashion_app/src/address/widgets/address_tile.dart';
import 'package:flutter/material.dart';

class AddressBlock extends StatelessWidget {
  const AddressBlock(
      {super.key, required this.address});

  final AddressModel? address;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableText(
          text: "Shipping Address",
          style: appStyle(14, Kolors.kPrimary, FontWeight.w500),
        ),
        AddressTile(
          address: address!,
          isCheckout: true,
        ),
      ],
    );
  }
}
