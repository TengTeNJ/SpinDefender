class BleFrame {
  final int cmd;
  final List<int> data;

  BleFrame({
    required this.cmd,
    required this.data,
  });

  @override
  String toString() {
    return 'BleFrame(cmd: 0x${cmd.toRadixString(16)}, data: $data)';
  }
}
