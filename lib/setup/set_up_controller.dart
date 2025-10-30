import 'package:flutter/material.dart';
import 'package:spin_defender/constants.dart';
import 'package:spin_defender/setup/favorite/favorite_list_viewu.dart';
import 'package:spin_defender/setup/favorite/favorite_model.dart';
import 'package:spin_defender/setup/setup_list_view.dart';
import 'package:spin_defender/setup/setup_model.dart';
import 'package:spin_defender/view/action_switch_view.dart';

import '../util/ble_util.dart';
import '../util/blue_tooth_manager.dart';
import '../util/dialog.dart';

enum CurrentMode {
  controlMode,// control模式
  favoriteMode // favoriteMode
}

class SetUpController extends StatefulWidget {
  const SetUpController({super.key});

  @override
  State<SetUpController> createState() => _SetUpControllerState();
}

class _SetUpControllerState extends State<SetUpController> {
  List<SetupModel> data = [
    SetupModel('images/profile/setting_ball_type.png','Ball Type',true),
    // SetupModel('images/profile/setting_roller_speed.png','Roller Speed',false),
    // SetupModel('images/profile/setting_reset_gap.png','Reset Gap',false),
  ];

  List<FavoriteModel> favoriteData = [
    FavoriteModel('Set up 01','2',"2.05.2025 14:29"),
    FavoriteModel('Set up 02','3',"3.10.2025 20:08"),
    FavoriteModel('Set up 03','1',"9.8.2025 09:57"),
  ];

  CurrentMode selectedMode = CurrentMode.controlMode;

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
                SizedBox(height: 60,),
                Constants.boldWhiteTextWidget("Set up", 22),
                SizedBox(height: 24,),
                
                Container(
                  margin: EdgeInsets.only(left: 24,right: 24),
                  child:ActionSwitchView(leftTitle: "Control", rightTitle: "My Favorites",
                      selectItem: (index){
                      print("men${index}");
                      if (index == 0) {
                        selectedMode = CurrentMode.controlMode;
                      } else {
                        selectedMode = CurrentMode.favoriteMode;
                      }
                      setState(() {});
                  }),
                ),
                SizedBox(height: 24,),

                Container(
                  margin: EdgeInsets.only(left: 24,right: 24),
                  width: Constants.screenWidth(context),
                  height: selectedMode == CurrentMode.controlMode ? data.length * 93 + (data.length - 1)*10 :
                  favoriteData.length * 93 + (favoriteData.length - 1)*10,
                  child: selectedMode == CurrentMode.controlMode ?
                   SetupListView(datas: data) :
                   FavoriteListViewu(datas: favoriteData),
                ),
                SizedBox(height: 12,),
                GestureDetector(onTap: (){
                   data.add(SetupModel("", "", false));
                   setState(() {});
                },
                child: data.length == 3 ||  selectedMode == CurrentMode.favoriteMode ? Container() :
                Container(
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
                ),
                // SizedBox(height: 120,),

                const Spacer(),
                selectedMode == CurrentMode.controlMode ?
                /// save
                GestureDetector(onTap: (){
                   print("保存SpinDefender 相关设置");
                },child: Container(
                   width: 55,
                   height: 55,
                   margin: const EdgeInsets.only(bottom: 44), // 离底部 64
                   decoration: BoxDecoration(
                      color: Constants.addSDBGColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                   child: Center(
                     child: Constants.regularWhiteTextWidget("Save", 16, Constants.saveTextColor),
                   ),
                 )
                ) :
                  Container(),
              ],
            ),
        ),
    );
  }
}
