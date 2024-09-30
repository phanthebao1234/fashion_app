import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/back_button.dart';
import 'package:fashion_app/common/widgets/custom_button.dart';
import 'package:fashion_app/common/widgets/error_modal.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/src/address/controllers/address_notifier.dart';
import 'package:fashion_app/src/address/models/create_address_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
            text: AppText.kAddShipping,
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
        leading: AppBackButton(),
        centerTitle: true,
      ),
      body:
          Consumer<AddressNotifier>(builder: (context, addressNotifier, child) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          children: [
            SizedBox(
              height: 20.h,
            ),
            _buildtextfield(
              hintText: 'Phone Number',
              keyboard: TextInputType.phone,
              controller: _phoneController,
              onSubmitted: (p) {},
            ),
            SizedBox(
              height: 20.h,
            ),
            _buildtextfield(
              hintText: 'Address',
              keyboard: TextInputType.text,
              controller: _addressController,
              onSubmitted: (p) {},
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                    List.generate(addressNotifier.addressTypes.length, (i) {
                  final addressType = addressNotifier.addressTypes[i];
                  return GestureDetector(
                    onTap: () {
                      // addressNotifier.clearAddressType();
                      print(addressNotifier.addressTypes[i]);
                      addressNotifier.setAddressType(addressType);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20.w),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: addressNotifier.addressType == addressType
                            ? Kolors.kPrimaryLight
                            : Kolors.kWhite,
                        borderRadius: kRadiusAll,
                        border: Border.all(
                          color: Kolors.kPrimary,
                          width: 1,
                        ),
                      ),
                      child: ReusableText(
                          text: addressType,
                          style: appStyle(
                              12,
                              addressNotifier.addressType == addressType
                                  ? Kolors.kWhite
                                  : Kolors.kDark,
                              FontWeight.normal)),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                      text: "Set this address as default",
                      style: appStyle(12, Kolors.kPrimary, FontWeight.normal)),
                  CupertinoSwitch(
                      value: addressNotifier.defaultToggle,
                      thumbColor: Kolors.kSecondaryLight,
                      activeColor: Kolors.kPrimary,
                      onChanged: (d) {
                        addressNotifier.setDefaultToggle(d);
                      })
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: CustomButton(
                btnHeight: 40.h,
                radius: 9,
                text: 'S U B M I T',
                onTap: () {
                  if (_phoneController.text.isNotEmpty &&
                      _addressController.text.isNotEmpty &&
                      addressNotifier.addressType != '') {
                    // add address
                    CreateAddress address = CreateAddress(
                      lat: 0.0,
                      lng: 0.0,
                      isDefault: addressNotifier.defaultToggle,
                      address: _addressController.text,
                      phone: _phoneController.text,
                      addressType: addressNotifier.addressType,
                    );

                    var data = creatAddressToJson(address);

                    addressNotifier.addAddress(data, context);
                  } else {
                    showErrorPopup(context, 'Missing Address Failed',
                        'Error Adding Address', false);
                  }
                },
              ),
            )
          ],
        );
      }),
    );
  }
}

class _buildtextfield extends StatelessWidget {
  const _buildtextfield({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.onSubmitted,
    this.keyboard,
    this.readOnly,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboard;
  final void Function(String)? onSubmitted;
  final bool? readOnly;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: TextField(
          keyboardType: keyboard,
          readOnly: readOnly ?? false,
          decoration: InputDecoration(
              hintText: hintText,
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kolors.kRed, width: 0.5),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kolors.kPrimary, width: 0.5),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kolors.kRed, width: 0.5),
              ),
              disabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kolors.kGray, width: 0.5),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kolors.kGray, width: 0.5),
              ),
              border: InputBorder.none),
          controller: controller,
          cursorHeight: 25,
          style: appStyle(12, Colors.black, FontWeight.normal),
          onSubmitted: onSubmitted),
    );
  }
}
