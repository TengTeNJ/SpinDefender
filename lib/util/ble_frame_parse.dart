import 'dart:async';

import '../models/ble_frame.dart';

class BleResponseCmd {
  static const int start = 0x90;
  static const int stop = 0x91;
  static const int forward = 0x92;
  static const int reverse = 0x93;
  static const int setSpeed = 0x94;
  static const int status = 0x95;
  static const int poweroff = 0x96;
}


class BleFrameAssembler {
  static const int frameHeader = 0xA6;
  static const int frameFooter = 0xBB;
  static const int timeoutMs = 150;

  final List<int> _buffer = [];
  DateTime? _lastReceiveTime;
  Timer? _timer;

  final void Function(BleFrame frame) onParsedFrame;

  BleFrameAssembler({required this.onParsedFrame});

  void onReceive(List<int> data) {
    _lastReceiveTime = DateTime.now();
    _buffer.addAll(data);
    _startTimer();
    _tryAssemble();
  }

  void _tryAssemble() {
    while (true) {
      if (_buffer.length < 3) return;

      int headerIndex = _buffer.indexOf(frameHeader);
      if (headerIndex < 0) {
        _buffer.clear();
        return;
      }

      if (headerIndex > 0) {
        _buffer.removeRange(0, headerIndex);
      }

      if (_buffer.length < 2) return;
      int length = _buffer[1];

      if (_buffer.length < length) return;

      if (_buffer[length - 1] != frameFooter) {
        _buffer.removeAt(0);
        continue;
      }

      final frame = _buffer.sublist(0, length);
      _buffer.removeRange(0, length);

      _handleFrame(frame);
    }
  }

  void _handleFrame(List<int> frame) {
    if (!_checkCs(frame)) return;

    final cmd = frame[2];
    final data = frame.sublist(3, frame.length - 2);

    onParsedFrame(BleFrame(cmd: cmd, data: data));
  }

  bool _checkCs(List<int> frame) {
    int cs = 0;
    for (int i = 0; i < frame.length - 2; i++) {
      cs += frame[i];
    }
    cs +=frameFooter;
    return (cs & 0xFF) == frame[frame.length - 2];
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: timeoutMs), () {
      if (_lastReceiveTime == null) return;
      if (DateTime.now()
          .difference(_lastReceiveTime!)
          .inMilliseconds >=
          timeoutMs) {
        _buffer.clear();
      }
    });
  }

  void dispose() {
    _timer?.cancel();
    _buffer.clear();
  }


}


