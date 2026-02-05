import 'package:flutter/cupertino.dart';

import 'device_status.dart';

class DeviceStatusNotifier extends ChangeNotifier {
  DeviceStatus _status = DeviceStatus(
    sysMode: SysMode.stop,
    motorMode: MotorMode.stop,
    motorSpeed: MotorSpeed.s80,
    battery: 100,
  );

  DeviceStatus get status => _status;

  void updateFromBle(DeviceStatus newStatus) {
    _status = newStatus;
    notifyListeners(); // 🔥 所有页面刷新
  }
  bool get isRunning => _status?.isRunning ?? false;

}
