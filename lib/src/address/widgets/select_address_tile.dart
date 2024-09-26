import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/src/address/controllers/address_notifier.dart';
import 'package:fashion_app/src/address/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SelectAddressTile extends StatelessWidget {
  const SelectAddressTile({
    super.key,
    required this.address,
  });

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressNotifier>(
        builder: (context, addressNotifier, child) {
      return ListTile(
          onTap: () {
            addressNotifier.setAddress(address);
            context.pop();
          },
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 27,
            backgroundColor: Kolors.kSecondaryLight,
            child: Icon(
              MaterialIcons.location_pin,
              color: Kolors.kPrimary,
              size: 30,
            ),
          ),
          title: ReusableText(
            text: address.addressType.toUpperCase(),
            style: appStyle(
              13,
              Kolors.kDark,
              FontWeight.w400,
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                text: address.address,
                style: appStyle(
                  10,
                  Kolors.kGray,
                  FontWeight.w400,
                ),
              ),
              ReusableText(
                text: address.phone,
                style: appStyle(
                  10,
                  Kolors.kGray,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
          trailing: ReusableText(
            text: addressNotifier.address != null &&
                    addressNotifier.address!.id == address.id
                ? "Selected"
                : "Select",
            style: appStyle(12, Kolors.kPrimaryLight, FontWeight.w400),
          ));
    });
  }
}
