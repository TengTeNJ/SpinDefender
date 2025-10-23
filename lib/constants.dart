import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {

  // 生成随机数
  static int randomNumberLeftMargin(int number) {
    return Random().nextInt(number);
  }

  static int randomNumberTopMargin(int number) {
    return Random().nextInt(number);
  }
  //  屏幕宽度
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  //  屏幕高度
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Text regularWhiteTextWidget(String text, double fontSize,Color color,
      {int? maxLines,
        TextAlign textAlign = TextAlign.center,
        double height = 1.0}) {
    return Text(
      maxLines: maxLines ?? null,
      textAlign: textAlign,
      text,
      style: TextStyle(
          height: height,
          fontFamily: 'SanFranciscoDisplay',
          fontWeight: FontWeight.w400,
          color: color,
          fontSize: fontSize),
    );
  }

  static Text mediumWhiteTextWidget(String text, double fontSize,Color color,
      {int maxLines = 1,
        TextAlign textAlign = TextAlign.center,
        double height = 1.0}) {
    return Text(
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.clip,
      text,
      style: TextStyle(
          height: height,
          fontFamily: 'SanFranciscoDisplay',
          fontWeight: FontWeight.w500,
          color: color,
          fontSize: fontSize),
    );
  }

  static Text boldWhiteTextWidget(String text, double fontSize,
      {int? maxLines,
        TextAlign textAlign = TextAlign.center,
        double height = 1.0}) {
    return Text(
      textAlign: textAlign,
      maxLines: maxLines,
      text,
      style: TextStyle(
        height: height,
        fontFamily: 'SanFranciscoDisplay',
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: fontSize,
      ),
    );
  }

  static Text boldBaseTextWidget(String text, double fontSize,
      {int maxLines = 1,
        TextAlign textAlign = TextAlign.center,
        double height = 1.0}) {
    return Text(
      textAlign: textAlign,
      maxLines: maxLines,
      text,
      style: TextStyle(
          height: height,
          fontFamily: 'SanFranciscoDisplay4',
          fontWeight: FontWeight.bold,
          color: Constants.baseStyleColor,
          fontSize: fontSize),
    );
  }

  static Text actionRegularGreyTextWidget(String text, double fontSize,
      {int? maxLines,
        TextAlign textAlign = TextAlign.center,
        double height = 1.0,
        TextOverflow? overflow}) {
    return Text(
      maxLines: maxLines ?? null,
      textAlign: textAlign,
      text,
      style: TextStyle(
          overflow: overflow,
          height: height,
          fontFamily: 'SanFranciscoDisplay',
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontSize: fontSize),
    );
  }

  static Text mediumBaseTextWidget(String text, double fontSize,
      {int maxLines = 1,
        TextAlign textAlign = TextAlign.center,
        double height = 1.0}) {
    return Text(
      maxLines: maxLines,
      textAlign: textAlign,
      text,
      style: TextStyle(
          height: height,
          fontFamily: 'SanFranciscoDisplay',
          fontWeight: FontWeight.w500,
          color: Constants.baseStyleColor,
          fontSize: fontSize),
    );
  }



  static Color darkThemeColor = Color.fromRGBO(38, 38, 48, 1);
  static Color darkThemeOpacityColor = Color.fromRGBO(41, 41, 54, 0.24);
  static Color baseStyleColor = Color.fromRGBO(248, 133, 11, 1);
  static Color baseGreyStyleColor = Color.fromRGBO(177, 177, 177, 1);
  static Color darkControllerColor = Color.fromRGBO(28, 29, 32, 1);

  static Color darkDialogColor = Color.fromRGBO(45, 45, 57, 1);

  static Color baseControllerColor = Color.fromRGBO(41, 41, 54, 1);
  static Color grayTextColor = Color.fromRGBO(156, 156, 156, 1);
  static Color connectTextColor = Color.fromRGBO(204, 204, 204, 1);
  static Color selectModelBgColor = Color.fromRGBO(56, 58, 64, 1);
  static Color selectedModelBgColor = Color.fromRGBO(233, 100, 21, 1);
  static Color baseTextGrayBgColor = Color.fromRGBO(67, 67, 65, 1);
  static Color selectedModelTransparencyBgColor = Color.fromRGBO(233, 100, 21, 0.39);
  static Color selectedModelOrangeBgColor = Color.fromRGBO(233, 100, 21, 1.0);
  static Color dialogBgColor = Color.fromRGBO(56, 58, 64, 1);
  static Color courtListBgColor = Color.fromRGBO(49, 52, 67, 1);
  static Color courtGridBgColor = Color.fromRGBO(6, 6, 6, 1);
  static Color addCourtBgColor = Color.fromRGBO(15, 16, 22, 1);
  static Color addCourtTextColor = Color.fromRGBO(248, 98, 21, 1);

  static Color bluetoothBGColor = Color.fromRGBO(32, 71, 209, 1);
  static Color bluetoothBGNewColor = Color.fromRGBO(54, 186, 255, 0.2);
  static Color timeTextColor = Color.fromRGBO(113, 113, 113, 1.0);
  static Color batteryBgColor = Color.fromRGBO(51, 51, 55, 1.0);
  static Color actionBgColor = Color.fromRGBO(45, 45, 57, 1.0);
  static Color actionHighBgColor = Color.fromRGBO(248, 98, 21, 1);

  static Color speedTextColor = Color.fromRGBO(180, 180, 180, 1.0);
  static Color speedSliderBGColor = Color.fromRGBO(159, 159, 159, 1);

  static Color addSDBGColor = Color.fromRGBO(74, 37, 5, 1.0);




  static String connectRobotText =
      'Connect your phone to the Bots Wi-Fi name will match your Bots serial number.The password is';

  static String kTcpIPAdress = '10.10.100.254';
  static int kTcpPort = 12345;


}

// 蓝牙设置名字
//const kBLEDevice_NewName = 'Myspeedz';
const kBLEDevice_NewName = 'Myspeedz';

// 新版本的digital shoots和270的蓝牙模块保持一致
const kBLE_270_SERVICE_UUID = "ffe0";
const kBLE_270_CHARACTERISTIC_NOTIFY_UUID = "ffe4";
const kBLE_270_CHARACTERISTIC_WRITER_UUID = "2A6F";
