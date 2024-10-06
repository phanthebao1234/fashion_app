import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/src/notification/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_time_ago/get_time_ago.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile(
      {super.key,
      this.onUpdate,
      required this.notification,
      required this.index});

  final NotificationModel notification;
  final void Function()? onUpdate;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUpdate,
      child: Container(
        decoration: BoxDecoration(
          color: index % 2 == 0 ? Kolors.kOffWhite : Kolors.kWhite,
          border: Border.symmetric(
            horizontal: BorderSide(width: .2.h, color: Kolors.kGrayLight),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Kolors.kSecondaryLight,
                child: Icon(
                  Icons.notifications,
                  color: Kolors.kPrimary,
                  size: 28.w,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    SizedBox(
                      width: ScreenUtil().screenWidth * .82,
                      child: Row(
                        children: [
                          ReusableText(
                            text: notification.title,
                            style: appStyle(
                                12, Kolors.kGrayLight, FontWeight.w500),
                          ),
                          const Spacer(),
                          ReusableText(
                            text: GetTimeAgo.parse(notification.createdAt),
                            style: appStyle(
                                12, Kolors.kGrayLight, FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().screenWidth * .82,
                      child: Text(
                        notification.message,
                        textAlign: TextAlign.justify,
                        maxLines: 3,
                        style: appStyle(9, Kolors.kGray, FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
