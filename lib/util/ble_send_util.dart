import 'package:spin_defender/util/ble_send_data.dart';
import 'package:spin_defender/util/blue_tooth_manager.dart';

import '../constants.dart';
import '../models/ble_model.dart';

class BleSendUtil {
  // 设置Sd 设备的速度
  static setSpinDefenderSpeed(int speed) {
    if (BluetoothManager().hasConnectedDeviceList.isEmpty) {
      return;
    }
   // BluetoothManager().writerDataToDevice(getWriterDevice(), setSpeedData(speed));
  }

  // 设置Sd 设备的旋转反向
  static setSpinDefenderRotation(int rotation) {
    if (BluetoothManager().hasConnectedDeviceList.isEmpty) {
      return;
    }
    //BluetoothManager().writerDataToDevice(getWriterDevice(), setRotationData(rotation));
  }

  static BLEModel getWriterDevice() {
    final model = BluetoothManager()
        .hasConnectedDeviceList
        .firstWhere((element) => element.device.name == kBLEDevice_NewName);
    return model;
  }

}