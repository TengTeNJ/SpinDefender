import 'package:flutter/material.dart';
import 'package:spin_defender/view/set_speed_view.dart';
import 'constants.dart';
import 'package:vibration/vibration.dart';


class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  String rorationImgPath = "images/bottom/icon_rotation.png";
  Color rotationBGColor = Constants.actionBgColor;

  String startImgPath = "images/bottom/icon_start.png";
  Color startBGColor = Constants.actionBgColor;
  String stopImgPath = "";

  /// A 贴左边，B 在屏幕中心
  Widget _buildBar() {
    return Row(
      children: [
        // 1. 左边控件
        const FlutterLogo(size: 36),   // 你可以换成任何 Widget

        // 2. 占空位，把中心线“推”到屏幕正中间
        Expanded(child: Container()),  // 只负责占位，不需要可视内容

        // 3. 屏幕中心控件（Row 剩余空间中心）
        const Center(
          child: Text('我在屏幕中间', style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: Scaffold(
         backgroundColor: Constants.darkControllerColor,
         body:SingleChildScrollView(
           child:Column(
             children: [
               Container(
                 margin: EdgeInsets.only(left: 0, top: 58),
                 width: Constants.screenWidth(context),
                 height: 40,
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     // 1️⃣ 左侧蓝牙按钮
                     Expanded(
                       child: Container(
                         alignment: Alignment.centerLeft, // 想靠左就 left
                         padding: const EdgeInsets.only(left: 19), // 代替原来的 margin
                         child: GestureDetector(
                           onTap: () {
                             print("蓝牙点击");
                             final language = Localizations.localeOf(context);
                             print("语言环境为$language");
                           },
                           child: Container(
                             width: 28,
                             height: 28,
                             decoration: BoxDecoration(
                               color: Constants.bluetoothBGNewColor,
                               borderRadius: BorderRadius.circular(14),
                             ),
                             child: Center(
                               child: Image.asset('images/bottom/bluetooth_icon.png',
                                   width: 10, height: 20),
                             ),
                           ),
                         ),
                       ),
                     ),

                     // 2️⃣ 中间图标
                     Expanded(
                       child: Center(
                         child: Image.asset('images/bottom/icon_potent.png',
                             width: Constants.screenWidth(context) / 2 - 80, height: 44),
                       ),
                     ),
                     // 3️⃣ 右侧占位（空 Expanded 即可，权重 1）
                     const Expanded(child: SizedBox.shrink()),
                   ],
                 ),
               ),

               Container(
                 margin: EdgeInsets.only(left: 0,top: 38) ,
                 child: Constants.boldWhiteTextWidget("00:20:10", 16),
               ),
               SizedBox(height: 8,),

               Constants.regularWhiteTextWidget("time", 12, Constants.timeTextColor),
               SizedBox(height: 36,),

               Stack(
                 alignment: Alignment.center, // 全局居中，省得再包 Center
                 children: [
                   Container(
                     width: 233,
                     height: 233,
                     decoration: const BoxDecoration(
                       image: DecorationImage(
                         image: AssetImage('images/bottom/icon_battery_bg.png'),
                         fit: BoxFit.cover,
                       ),
                     ),
                   ),

                   Container(
                     width: 189,
                     height: 189,
                     decoration: BoxDecoration(
                       // 线性渐变：上 → 下
                       gradient: const LinearGradient(
                         begin: Alignment.topCenter,
                         end: Alignment.bottomCenter,
                         colors: [
                           Color.fromRGBO(51, 51, 55, 1.0), // 底部颜色
                           Color.fromRGBO(15, 15, 22, 1.0), // 顶部颜色
                         ],
                       ),
                       borderRadius: BorderRadius.circular(189/2),
                     ),
                     child:Column(
                       children: [
                         SizedBox(height: 26,),
                         Image.asset("images/bottom/icon_battery.png",width:16 ,height: 18,),

                         Center(
                           child:Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             // crossAxisAlignment: CrossAxisAlignment.baseline,
                             children: [
                               Text(
                                 "${87}",
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 64,
                                     fontFamily: 'tengxun',
                                     color: Colors.white),
                               ),
                               SizedBox(width: 6,),
                               Text(
                                 "%",
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 38,
                                     fontFamily: 'tengxun',
                                     color: Colors.white),
                               ),
                             ],
                           ),
                         ),

                         SizedBox(height: 5,),
                         Constants.regularWhiteTextWidget("Battery", 16, Constants.timeTextColor),
                       ],
                     ),
                   ),
                 ],
               ),

               SizedBox(height: 40,),
               Container(
                 width: 300,
                 height: 40,
                 child: SetSpeedView(),
               ),

               Center(
                 child:Constants.regularWhiteTextWidget("Speed", 16, Constants.speedTextColor),
               ),
               SizedBox(height: 40,),

               Container(
                 width: Constants.screenWidth(context) - 60*2,
                 height: 100,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     GestureDetector(onTap: (){
                       Vibration.vibrate(duration: 200);
                       rotationBGColor = Constants.actionHighBgColor;
                       rorationImgPath = "images/bottom/icon_rotation_white.png";
                       Future.delayed(Duration(milliseconds: 500), () {
                         rotationBGColor = Constants.actionBgColor;
                         rorationImgPath = "images/bottom/icon_rotation.png";
                         setState(() {});
                       });
                       setState(() {});
                     },
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(
                             width: 80,
                             height: 80,
                             decoration: BoxDecoration(
                               color: rotationBGColor,
                               borderRadius: BorderRadius.circular(8),
                             ),
                             child: Center(
                               child: Image.asset("${rorationImgPath}",width:29 ,height: 32,),
                             ),
                           ),
                           SizedBox(height: 4,),
                           Constants.regularWhiteTextWidget("Rotation", 16, Constants.speedTextColor),
                         ],
                       ),
                     ),




                     Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         GestureDetector(onTap: (){
                           Vibration.vibrate(duration: 200);
                           startBGColor = Constants.actionHighBgColor;
                           startImgPath = "images/bottom/icon_start_white.png";
                           Future.delayed(Duration(milliseconds: 500), () {
                             startBGColor = Constants.actionBgColor;
                             startImgPath = "images/bottom/icon_start.png";
                             setState(() {});
                           });
                           setState(() {});
                         },
                           child:Container(
                             width: 80,
                             height: 80,
                             decoration: BoxDecoration(
                               color: startBGColor,
                               borderRadius: BorderRadius.circular(8),
                             ),
                             child: Center(
                               child: Image.asset("${startImgPath}",width:17 ,height: 24,),
                             ),
                           ),
                         ),

                         SizedBox(height: 4,),
                         Constants.regularWhiteTextWidget("Start", 16, Constants.speedTextColor),
                       ],
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
