import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/src/cart/views/cart_screen.dart';
import 'package:fashion_app/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:fashion_app/src/home/views/home_screen.dart';
import 'package:fashion_app/src/profile/views/profile_screen.dart';
import 'package:fashion_app/src/wishlist/views/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AppEntryPoint extends StatelessWidget {
  AppEntryPoint({super.key});

  List<Widget> pageList = [
    const HomePage(),
    const Profile(),
    const WishListPage(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TabIndexNotifier>(
      builder: (context, tabIndexNotifier, child) {
        return Scaffold(
          body: Stack(
            children: [
              pageList[tabIndexNotifier.index],
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                    data: Theme.of(context)
                        .copyWith(canvasColor: Kolors.kOffWhite),
                    child: BottomNavigationBar(
                      selectedFontSize: 12,
                      elevation: 0,
                      backgroundColor: Kolors.kOffWhite,
                      selectedLabelStyle:
                          appStyle(9, Kolors.kPrimary, FontWeight.w500),
                      showSelectedLabels: true,
                      showUnselectedLabels: false,
                      currentIndex: tabIndexNotifier.index,
                      selectedItemColor: Kolors.kPrimary,
                      unselectedItemColor: Kolors.kGray,
                      unselectedIconTheme:
                          const IconThemeData(color: Colors.black38),
                      onTap: (i) {
                        tabIndexNotifier.setIndex(i);
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: tabIndexNotifier.index == 0
                              ? Icon(
                                  AntDesign.home,
                                  color: Kolors.kPrimary,
                                  size: 24,
                                )
                              : Icon(
                                  AntDesign.home,
                                  color: Kolors.kPrimary,
                                  size: 24,
                                ),
                          label: "Home",
                        ),
                        BottomNavigationBarItem(
                            icon: tabIndexNotifier.index == 1
                                ? Icon(
                                    EvilIcons.user,
                                    color: Kolors.kPrimary,
                                    size: 34,
                                  )
                                : Icon(
                                    EvilIcons.user,
                                    size: 34,
                                  ),
                            label: "Profile"),
                        BottomNavigationBarItem(
                            icon: tabIndexNotifier.index == 2
                                ? Icon(
                                    Ionicons.heart,
                                    color: const Color.fromRGBO(91, 62, 43, 1),
                                    size: 24,
                                  )
                                : Icon(
                                    Ionicons.heart_outline,
                                  ),
                            label: "Wishlist"),
                        BottomNavigationBarItem(
                            icon: Badge(
                              label: Text("9"),
                              child: tabIndexNotifier.index == 3
                                  ? Icon(
                                      MaterialCommunityIcons.shopping,
                                      color: Kolors.kPrimary,
                                      size: 24,
                                    )
                                  : Icon(
                                      MaterialCommunityIcons.shopping_outline,
                                    ),
                            ),
                            label: "Cart"),
                      ],
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
