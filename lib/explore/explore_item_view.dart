import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spin_defender/explore/full_screen_video.dart';

import '../constants.dart';
import '../setup/setup_model.dart';

class ExploreItemView extends StatefulWidget {
  SetupModel model;
  ExploreItemView({required this.model});

  @override
  State<ExploreItemView> createState() => _ExploreItemViewState();
}

class _ExploreItemViewState extends State<ExploreItemView> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
 }

 @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Constants.dialogBgColor,
          borderRadius: BorderRadius.circular(10)
      ),
      height: 292,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24,left:16 ),
                    child:Constants.boldWhiteTextWidget("Turn & Shots", 18),
                  ),
                  SizedBox(height: 4,),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child:Constants.regularWhiteTextWidget("00:04:30", 12, Constants.speedSliderBGColor),
                  )
                ],
              ),

              GestureDetector(onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FullScreenVideo()),
                );
              },
               child:Container(
                 margin: EdgeInsets.only(right: 16,top: 8),
                 child:Image.asset('images/home/right_arrow_icon.png',
                     width: 73/3, height: 73/3),
               ),
              )
            ],
          ),

          SizedBox(height: 6,),
          // Container(
          //   color: Colors.red,
          //   margin: EdgeInsets.only(left: 16,right: 16),
          //   child:Image.asset('images/home/thumb.jpg',
          //       width: Constants.screenWidth(context) - 64, height: 200,
          //       fit: BoxFit.cover,
          //   ),
          // ),
          Container(                                  // 外层红色区域
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Stack(
              alignment: Alignment.center,            // 居中叠加
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  // color: Colors.red,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: AssetImage(
                      'images/home/thumb.jpg'),
                      // width: double.infinity,
                      // height: 200,
                      fit: BoxFit.cover,
                    ),

                  ),

                  // child: Image.asset(
                  //   'images/home/thumb.jpg',
                  //   width: double.infinity,
                  //   height: 200,
                  //   fit: BoxFit.cover,
                  // ),
                ),

                // 2. 上层：你想加的内容（示例：圆角白框）
               GestureDetector(onTap: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => FullScreenVideo()),
                 );
               },
               child:Container(
                   width: 47,
                   height: 47,
                   decoration: BoxDecoration(
                     color: Colors.white.withOpacity(0.53),
                   ),
                   alignment: Alignment.center,
                   child: Image.asset("images/home/stop_icon.png",width: 47,height: 47,)
               ),
               ),
              ],
            ),
          ),
          SizedBox(height: 24,),
        ],
      ),
    );
  }

}
