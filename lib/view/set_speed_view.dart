import 'package:flutter/material.dart';

import '../constants.dart';
import 'package:vibration/vibration.dart';


// 设置速度的view
class SetSpeedView extends StatefulWidget {
  const SetSpeedView({super.key});

  @override
  State<SetSpeedView> createState() => _SetSpeedViewState();
}

class _SetSpeedViewState extends State<SetSpeedView> {
  String reduceImgPath = "images/bottom/icon_reduce.png";
  Color reduceBGColor = Constants.actionBgColor;
  String addImgPath = "images/bottom/icon_add.png";
  Color addBGColor = Constants.actionBgColor;
  double sliderValue = 1.0;
  double sliderWidth = 144.0;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(onTap: (){
          Vibration.vibrate(duration: 200);
          reduceImgPath = "images/bottom/icon_reduce_white.png";
          reduceBGColor = Constants.actionHighBgColor;
          Future.delayed(Duration(milliseconds: 500), () {
            reduceBGColor = Constants.actionBgColor;
            reduceImgPath = "images/bottom/icon_reduce.png";
            setState(() {});
          });
          if(sliderValue >=1.0) {
            sliderValue -= 1.0;
          }
          setState(() {});

        },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: reduceBGColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Image.asset("${reduceImgPath}",width:16 ,height: 2,),
            ),
          ),
        ),
        SizedBox(width: 14,),

        /// 进度条
        Stack(
          children: [
            Positioned(child: Container(
              width: sliderWidth,
              height: 5,
              decoration: BoxDecoration(
                color: Constants.speedSliderBGColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),),

            Positioned(
                left: 0,
                top: 0,
                width: sliderWidth *sliderValue/3 ,
                height: 5,
                child: Container(
                  width: 145,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Constants.addCourtTextColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),)
             ],
          ),

        SizedBox(width: 14,),

        GestureDetector(onTap: (){
          Vibration.vibrate(duration: 200);
          addImgPath = "images/bottom/icon_add_white.png";
          addBGColor = Constants.actionHighBgColor;
          Future.delayed(Duration(milliseconds: 500), () {
            addBGColor = Constants.actionBgColor;
            addImgPath = "images/bottom/icon_add.png";
            if(!mounted) return;
            setState(() {});
          });
          if(sliderValue <3.0) {
            sliderValue += 1.0;
          }
          setState(() {});
          },
        child:Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: addBGColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Image.asset("${addImgPath}",width:16 ,height: 16,),
          ),
        ),
        ),
      ],
    );
  }
}
