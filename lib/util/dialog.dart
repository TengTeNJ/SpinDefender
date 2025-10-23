import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spin_defender/view/set_speed_view.dart';

import '../constants.dart';
import '../view/ble_list_view.dart';
import 'color.dart';
import 'package:vibration/vibration.dart';


class TTDialog {
  /**蓝牙列表**/
  static bleListDialog(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // 设置为false话 弹窗的高度就会固定
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: BLEListDialog(),
        );
      },
    );
  }

  // 设置相关参数
  static setSpinDefenderParameter(BuildContext context) {
    showModalBottomSheet(
        backgroundColor:  Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: setSpinDefenderParameterDialog(),
          );
        });
  }

}

class setSpinDefenderParameterDialog extends StatefulWidget {
  const setSpinDefenderParameterDialog({super.key});

  @override
  State<setSpinDefenderParameterDialog> createState() => setSpinDefenderParameterDialogState();

}

class setSpinDefenderParameterDialogState extends State<setSpinDefenderParameterDialog> {
  String rorationImgPath = "images/bottom/icon_rotation.png";
  Color rotationBGColor = Constants.actionBgColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Constants.darkControllerColor,
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Constants.boldWhiteTextWidget("Spin Defender 01", 18),
          SizedBox(height: 36,),
          SetSpeedView(),
          Constants.regularWhiteTextWidget("Speed", 16, Constants.speedTextColor),
          SizedBox(height: 63,),
          Container(
            // color: Colors.red,
            width: Constants.screenWidth(context) - 146*2,
            height: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      SizedBox(height: 12,),
                      Constants.regularWhiteTextWidget("Rotation", 16, Constants.speedTextColor),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),

    );

  }
}

/**蓝牙列表弹窗**/
class BLEListDialog extends StatefulWidget {
  const BLEListDialog({super.key});

  @override
  State<BLEListDialog> createState() => _BLEListDialogState();
}

class _BLEListDialogState extends State<BLEListDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: Constants.darkControllerColor),
      child: Stack(
        children: [
          Positioned(
              top: 8,
              left: (Constants.screenWidth(context) - 80) / 2.0,
              child: Container(
                  width: 80,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromRGBO(89, 105, 138, 0.4),
                  ))),
          Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  print('begain scan');
                  // BleUtil.begainScan(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          color: hexStringToColor('#65657D'),
                          borderRadius: BorderRadius.circular(18)),
                      child: Center(
                        child: Image(
                            image: AssetImage('images/setup/scan.png'),
                            width: 16),
                      ),
                    )
                  ],
                ),
              )),
          Positioned(
            child: BleListView(),
            top: 45,
            bottom: 99,
          ),
          Positioned(
            child: GestureDetector(
              onTap: () {
                // NavigatorUtil.pop();
              },
              child: Container(
                child: Center(
                  child: Constants.regularWhiteTextWidget("Cancel", 16, Colors.white),

                ),
                decoration: BoxDecoration(
                    color: Constants.baseStyleColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            left: 83,
            right: 83,
            bottom: 42,
            height: 40,
          )
        ],
      ),
    );
  }
}