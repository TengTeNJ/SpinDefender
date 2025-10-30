import 'package:flutter/material.dart';

import '../constants.dart';

/// 功能切换view
class ActionSwitchView extends StatefulWidget {
  String leftTitle;
  String rightTitle;
  Function? selectItem;

  ActionSwitchView({required this.leftTitle, required this.rightTitle,required this.selectItem});

  @override
  State<ActionSwitchView> createState() => _ActionSwitchViewState();
}

class _ActionSwitchViewState extends State<ActionSwitchView> {
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (_currentIndex == 0) {
              return;
            }
            setState(() {
              _currentIndex = 0;
            });
            if (widget.selectItem != null) {
              widget.selectItem!(_currentIndex);
            }
          },
          child: Column(
            children: [
              _currentIndex == 0 ? 
              Constants.boldWhiteTextWidget("${widget.leftTitle}", 18) :
              Constants.boldBaseTextWidget("${widget.leftTitle}", 18,textColor: Constants.timeTextColor) ,

              SizedBox(height: 4,),
              Container(
               width: (Constants.screenWidth(context) - 48) /2,
               height: 3,
               color: _currentIndex == 0 ? Constants.actionSwitchBGHighColor : Constants.actionSwitchBGColor,
               ),
            ],
          )
        ),

        GestureDetector(
          onTap: () {
            if (_currentIndex == 1) {
              return;
            }
            setState(() {
              _currentIndex = 1;
            });
            if (widget.selectItem != null) {
              widget.selectItem!(_currentIndex);
            }
          },
          child:  Column(
            children: [
              _currentIndex == 1 ?
              Constants.boldWhiteTextWidget("${widget.rightTitle}", 18) :
              Constants.boldBaseTextWidget("${widget.rightTitle}", 18,textColor: Constants.timeTextColor) ,
              SizedBox(height: 4,),
              Container(
                width: (Constants.screenWidth(context) - 48) /2,
                height: 3,
                color: _currentIndex == 1 ? Constants.actionSwitchBGHighColor : Constants.actionSwitchBGColor,
              ),
            ],
          )
        )
      ],
    );

  }
}
