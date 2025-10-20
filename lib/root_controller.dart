import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:spin_defender/chart/chart_controller.dart';
import 'package:spin_defender/home_controller.dart';
import 'package:spin_defender/video/video_controller.dart';

import 'constants.dart';

class RootController extends StatefulWidget {
  const RootController({super.key});

  @override
  State<RootController> createState() => _RootControllerState();
}

class _RootControllerState extends State<RootController> {
  int _currentIndex= 0;

  final List<StatefulWidget> _pageviews = [
    HomeController(),
    ChartController(),
    VideoController(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Constants.darkThemeColor,
        style: TabStyle.fixedCircle,
        top: -25, curveSize: 160,
        height: 64,
        items: [
          TabItem(icon: Image.asset('images/bottom/icon_home.png'),
              activeIcon: Image.asset('images/bottom/icon_home.png'),isIconBlend: true ,title: 'Explore'),
          TabItem(icon: Image.asset('images/bottom/icon_action.png'),
              activeIcon: Image.asset('images/bottom/icon_action.png'), title: ''),
          TabItem(icon: Image.asset('images/bottom/icon_setup.png'),
              activeIcon: Image.asset('images/bottom/icon_setup.png'),isIconBlend: false, title: 'Setup'),
        ],
        onTap: (int i) {
          setState(() {
            _currentIndex = i;
          });
          },
      ),
      body: _pageviews[_currentIndex],
    );

  }
}
