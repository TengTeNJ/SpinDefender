import 'package:flutter/material.dart';
import 'package:spin_defender/explore/explore_list_view.dart';

import '../constants.dart';
import '../setup/setup_model.dart';

class ExploreController extends StatefulWidget {
  const ExploreController({super.key});

  @override
  State<ExploreController> createState() => _ExploreControllerState();
}

class _ExploreControllerState extends State<ExploreController> {
  List<SetupModel> data = [
    SetupModel('images/profile/setting_ball_type.png','Ball Type',true),
    SetupModel('images/profile/setting_roller_speed.png','Roller Speed',false),
    SetupModel('images/profile/setting_reset_gap.png','Reset Gap',false),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Constants.darkControllerColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 48,),
            Constants.boldWhiteTextWidget("Explore", 22),
            SizedBox(height: 24,),
            Container(
              padding: EdgeInsets.only(left: 24,right: 24),
              width: Constants.screenWidth(context),
              height: 400,
              child:ExploreListView(datas: data) ,
            ),
            SizedBox(height: 12,),
          ],
        ),
      ),
    );
  }
}
