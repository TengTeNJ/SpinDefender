/// 系统模式
enum SysMode {
  stop,   // 0 停止模式
  start;  // 1 启动模式

  static SysMode fromValue(int v) {
    return v == 1 ? SysMode.start : SysMode.stop;
  }
}

/// 电机模式
enum MotorMode {
  forward, // 1 正转
  stop,    // 2 停止
  reverse; // 3 反转

  static MotorMode fromValue(int v) {
    switch (v) {
      case 1:
        return MotorMode.forward;
      case 3:
        return MotorMode.reverse;
      case 2:
      default:
        return MotorMode.stop;
    }
  }
}

/// 速度档位（固定 4 档）
enum MotorSpeed {
  s30(30),
  s60(60),
  s80(80),
  s100(100);

  final int value;
  const MotorSpeed(this.value);

  static MotorSpeed fromValue(int v) {
    switch (v) {
      case 30:
        return MotorSpeed.s30;
      case 60:
        return MotorSpeed.s60;
      case 80:
        return MotorSpeed.s80;
      case 100:
        return MotorSpeed.s100;
      default:
        return MotorSpeed.s30; // 容错默认
    }
  }
}

class DeviceStatus {
  final SysMode sysMode;         // DATA[0]
  final MotorMode motorMode;     // DATA[1]
  final MotorSpeed motorSpeed;   // DATA[2]
  final int battery;             // DATA[3] 0–100

  const DeviceStatus({
    required this.sysMode,
    required this.motorMode,
    required this.motorSpeed,
    required this.battery,
  });

  /// 从蓝牙状态 DATA 解析（必须 4 字节）
  factory DeviceStatus.fromBleData(List<int> data) {
    if (data.length != 4) {
      throw ArgumentError('状态数据必须为 4 字节: $data');
    }

    return DeviceStatus(
      sysMode: SysMode.fromValue(data[0]),
      motorMode: MotorMode.fromValue(data[1]),
      motorSpeed: MotorSpeed.fromValue(data[2]),
      battery: data[3].clamp(0, 100),
    );
  }

  /// 是否运行中
  bool get isRunning => sysMode == SysMode.start;

  @override
  String toString() {
    return 'DeviceStatus('
        'sysMode: ${sysMode.name}, '
        'motorMode: ${motorMode.name}, '
        'motorSpeed: ${motorSpeed.value}, '
        'battery: $battery%'
        ')';
  }
}

