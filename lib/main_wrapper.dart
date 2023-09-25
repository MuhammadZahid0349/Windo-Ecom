import 'package:animate_do/animate_do.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:windo_ecom/Constants/ColorConstants.dart';
import 'package:windo_ecom/Constants/utils.dart';
import 'package:windo_ecom/screens/explorescreen.dart';
import 'package:windo_ecom/screens/profilescreen.dart';
import 'package:windo_ecom/screens/settingscreen.dart';

import '../screens/cart.dart';
import '../screens/home.dart';
import '../screens/search.dart';
import '../utils/constants.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late int _index = 0;
  bool isSearchActive = false;

  List<Widget> screens = const [
    Home(),
    Search(),
    ExploreScreen(),
    SettingScreen(),
    ProfileScreen()
  ];

  double getAppBarHeight(int index) {
    // Return the appropriate app bar height based on the index.
    return (index == 0 || index == 1) ? kToolbarHeight : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getAppBarHeight(_index)),
        child: AppBar(
          title: FadeIn(
            delay: const Duration(milliseconds: 300),
            child: CustomizedText(
                text: "Windo Ecom",
                color: skyColor2,
                size: 17.sp,
                FontWeight: FontWeight.w800),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: skyColor2,
              size: 30,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(
                  LineIcons.shoppingBag,
                  color: skyColor2,
                  size: 30.sp,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Cart(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: screens[_index],
      bottomNavigationBar: BottomBarBubble(
        color: skyColor2,
        selectedIndex: _index,
        items: [
          BottomBarItem(iconData: Icons.home),
          BottomBarItem(iconData: Icons.search),
          BottomBarItem(iconData: Icons.explore),
          BottomBarItem(iconData: Icons.settings),
          BottomBarItem(iconData: Icons.person),
        ],
        onSelect: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
