import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:spin_defender/explore/explore_controller.dart';
import 'package:spin_defender/home_controller.dart';
import 'package:spin_defender/setup/set_up_controller.dart';

import 'constants.dart';

class RootController extends StatefulWidget {
  const RootController({super.key});

  @override
  State<RootController> createState() => _RootControllerState();
}

class _RootControllerState extends State<RootController> {
  int _currentIndex= 0;
  double margin = 0.0;
  String homeImgPath = "images/bottom/icon_controller.png";

  TabStyle style = TabStyle.fixed;
  final List<StatefulWidget> _pageviews = [
    ExploreController(),
    HomeController(),
    SetUpController(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Constants.darkThemeColor,
        style:style,
        top: margin, curveSize: 160,
        activeColor: Constants.selectedModelBgColor,
        height: 64,
        items: [
          TabItem(icon: Image.asset('images/bottom/icon_home.png'),
              activeIcon: Image.asset('images/bottom/icon_home.png'),isIconBlend: true ,title: 'Explore'),
          TabItem(icon: Image.asset('images/bottom/icon_controller.png'),
              activeIcon: Image.asset('images/bottom/icon_action.png'), isIconBlend: false ,title: 'Controller'),
          TabItem(icon: Image.asset('images/bottom/icon_setup.png'),
              activeIcon: Image.asset('images/bottom/icon_setup.png'),isIconBlend: false, title: 'Setup'),
        ],
        onTap: (int i) {
          setState(() {
            _currentIndex = i;
            print("当前点击的索引${i}");
            if (i == 1) {
              margin = -25;
              style = TabStyle.fixedCircle;
            } else {
              margin = 0;
              style = TabStyle.fixed;
            }
           });
          },
      ),
      body: _pageviews[_currentIndex],
    );

  }
}
