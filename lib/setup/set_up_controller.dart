import 'package:flutter/material.dart';
import 'package:spin_defender/constants.dart';
import 'package:spin_defender/setup/setup_list_view.dart';
import 'package:spin_defender/setup/setup_model.dart';

import '../util/ble_util.dart';
import '../util/blue_tooth_manager.dart';
import '../util/dialog.dart';

class SetUpController extends StatefulWidget {
  const SetUpController({super.key});

  @override
  State<SetUpController> createState() => _SetUpControllerState();
}

class _SetUpControllerState extends State<SetUpController> {
  List<SetupModel> data = [
    SetupModel('images/profile/setting_ball_type.png','Ball Type',true),
    SetupModel('images/profile/setting_roller_speed.png','Roller Speed',false),
    // SetupModel('images/profile/setting_reset_gap.png','Reset Gap',false),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BluetoothManager();
    // 扫描蓝牙设备
    Future.delayed(Duration(milliseconds: 1000),(){
      BleUtil.begainScan(context);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Constants.darkControllerColor,
        child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 48,),
                Constants.boldWhiteTextWidget("Set up", 22),
                SizedBox(height: 24,),
                Container(
                  // color:  Colors.red,
                  margin: EdgeInsets.only(left: 24,right: 24),
                  width: Constants.screenWidth(context),
                  // height: 200,
                  child:SetupListView(datas: data) ,
                ),
                SizedBox(height: 12,),

                GestureDetector(onTap: (){
                  // TTDialog.bleListDialog(context);

                },
                child:Container(
                  width: Constants.screenWidth(context) - 48,
                  height: 93,
                  decoration: BoxDecoration(
                    color: Constants.addSDBGColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset("images/setup/add_sd_icon.png",width:63/2 ,height: 63/2,),
                  ),
                ),
                )




              ],
            ),
        ),
    );
  }
}
