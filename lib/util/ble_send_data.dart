import 'package:spin_defender/constants.dart';

/// 设置SpinDefender 的速度
List<int> setSpeedData(int speed) {  //1 2 3 三个档位
  int start = kDataFrameHeader;
  int length = 6;
  int cmd = 0x47;
  int data = speed;
  int cs = start + length + cmd + data;
  int end = kDataFrameFoot;
  print('设置SD的速度:${[start, length, cmd, data, cs, end]}');
  return [start, length, cmd, data, cs, end];
}

List<int> setRotationData(int speed) {
  int start = kDataFrameHeader;
  int length = 6;
  int cmd = 0x47;
  int data = speed;
  int cs = start + length + cmd + data;
  int end = kDataFrameFoot;
  print('设置SD的rotation:${[start, length, cmd, data, cs, end]}');
  return [start, length, cmd, data, cs, end];
}