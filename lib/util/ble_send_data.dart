import 'package:spin_defender/constants.dart';

enum SpinDefenderCmd {
  start(0x10), //开启
  stop(0x11), // 停止
  forward(0x12), // 正转
  reverse(0x13), // 反转
  setSpeed(0x14), //  设置速度
  requestStatus(0x15), //  请求状态
  powerOff(0x16), // 关机
  setPWM(0x17);// 设置PWM占空比

  final int value;
  const SpinDefenderCmd(this.value);
}


List<int> buildFrame({
  required int cmd,
  int? data,
}) {
  final int start = kDataFrameHeader;
  final int end = kDataFrameFoot;

  final bool hasData = data != null;
  final int length = hasData ? 6 : 5;

  int cs = start + length + cmd +  end;
  if (hasData) {
    cs += data!;
  }
  cs = cs & 0xFF;

  final frame = [
    start,
    length,
    cmd,
    if (hasData) data!,
    cs,
    end,
  ];

  print('SpinDefender -> $frame');
  return frame;
}
