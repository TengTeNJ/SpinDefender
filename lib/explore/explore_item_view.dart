import 'package:flutter/material.dart';

import '../constants.dart';
import '../setup/setup_model.dart';

class ExploreItemView extends StatefulWidget {
  SetupModel model;


  ExploreItemView({required this.model});

  @override
  State<ExploreItemView> createState() => _ExploreItemViewState();
}

class _ExploreItemViewState extends State<ExploreItemView> {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Constants.dialogBgColor,
          borderRadius: BorderRadius.circular(10)
      ),
      height: 93,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(widget.model.isConnected ? 'images/setup/battery_high_icon.png' :
                  'images/setup/battery_icon.png',
                      width: 96, height: 90),
                  SizedBox(width: 2,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Constants.boldWhiteTextWidget("Turn & Shots", 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(widget.model.isConnected ? 'images/setup/battery_high_icon.png' :
                          'images/setup/battery_icon.png',
                              width: 12, height: 15),
                          SizedBox(width: 2,),

                          Constants.regularWhiteTextWidget("1 Player 2 Pods", 14, Constants.speedTextColor),
                        ],
                      )

                    ],
                  ),


                ],
              ),
            ],
          ),
          Image.asset(widget.model.isConnected ? 'images/setup/battery_high_icon.png' :
          'images/setup/battery_icon.png',
              width: 33, height: 33),

        ],
      ),
    );
  }

}
