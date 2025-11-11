import 'package:flutter/material.dart';
import 'package:spin_defender/constants.dart';
import 'package:spin_defender/setup/setup_model.dart';
import 'package:spin_defender/util/dialog.dart';

class SetupItemView extends StatefulWidget {
  SetupModel model;

  SetupItemView({required this.model});

  @override
  State<SetupItemView> createState() => _SetupItemViewState();
}

class _SetupItemViewState extends State<SetupItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Constants.dialogBgColor,
        borderRadius: BorderRadius.circular(10)
      ),
      height: 93,
      child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Constants.boldWhiteTextWidget("${widget.model.title}", 18),
              SizedBox(height: 10,),

              // 电量
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(widget.model.isConnected ? 'images/setup/battery_high_icon.png' :
                  'images/setup/battery_icon.png',
                      width: 24, height: 12),
                  SizedBox(width: 2,),

                  widget.model.isConnected ?
                  Constants.regularWhiteTextWidget("100%", 12, Colors.white) :
                  Container()

                ],
              ),
            ],
          ),

          GestureDetector(onTap: (){
            TTDialog.bleListDialog(context);
            },
          child:Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: widget.model.isConnected ? Constants.bluetoothBGNewColor : Constants.timeTextColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(widget.model.isConnected ? "images/setup/bluetooth_high_icon.png"
                  : "images/setup/bluetooth_icon.png"
                ,width:14 ,height: 18,),
            ),
          ),
          ),


          GestureDetector(onTap: (){
            TTDialog.setSpinDefenderParameter(context);
            },
          child:Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: widget.model.isConnected ? Constants.actionHighBgColor: Constants.timeTextColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(widget.model.isConnected ?"images/setup/setting_high_icon.png"
                  : "images/setup/setting_icon.png"
                ,width:14 ,height: 18,),
            ),
          ),
          ),


          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color:widget.model.isConnected ? Constants.actionHighBgColor:Constants.timeTextColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(widget.model.isConnected ?"images/setup/start_high_icon.png"
                : "images/setup/start_icon.png"
                ,width:14 ,height: 18,),
            ),
          ),
        ],
      ),
    );
  }
}
