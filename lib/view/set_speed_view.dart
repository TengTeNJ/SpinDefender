import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../constants.dart';

class SetSpeedView extends StatefulWidget {
  /// 速度变化回调（给蓝牙 / 业务用）
  final ValueChanged<int>? onSpeedChanged;

  const SetSpeedView({super.key, this.onSpeedChanged});

  @override
  State<SetSpeedView> createState() => _SetSpeedViewState();
}

class _SetSpeedViewState extends State<SetSpeedView> {
  final List<int> speedLevels = [30,60, 80, 100];
  int speedIndex = 0; // 当前档位

  final double sliderWidth = 144.0;

  String reduceImg = "images/bottom/icon_reduce.png";
  String addImg = "images/bottom/icon_add.png";

  Color reduceBg = Constants.actionBgColor;
  Color addBg = Constants.actionBgColor;

  bool get canReduce => speedIndex > 0;
  bool get canAdd => speedIndex < speedLevels.length - 1;

  double get sliderProgress =>
      (speedIndex + 1) / speedLevels.length;

  /// 按钮点击反馈
  void _buttonFeedback({
    required bool isAdd,
  }) {
    Vibration.vibrate(duration: 200);

    setState(() {
      if (isAdd) {
        addImg = "images/bottom/icon_add_white.png";
        addBg = Constants.actionHighBgColor;
      } else {
        reduceImg = "images/bottom/icon_reduce_white.png";
        reduceBg = Constants.actionHighBgColor;
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        addImg = "images/bottom/icon_add.png";
        reduceImg = "images/bottom/icon_reduce.png";
        addBg = Constants.actionBgColor;
        reduceBg = Constants.actionBgColor;
      });
    });
  }

  void _onReduce() {
    if (!canReduce) return;

    _buttonFeedback(isAdd: false);

    setState(() {
      speedIndex--;
    });

    widget.onSpeedChanged?.call(speedLevels[speedIndex]);
  }

  void _onAdd() {
    if (!canAdd) return;

    _buttonFeedback(isAdd: true);

    setState(() {
      speedIndex++;
    });

    widget.onSpeedChanged?.call(speedLevels[speedIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// -
        GestureDetector(
          onTap: canReduce ? _onReduce : null,
          child: Opacity(
            opacity: canReduce ? 1.0 : 0.4,
            child: _actionButton(
              bgColor: reduceBg,
              image: reduceImg,
              imageSize: const Size(16, 2),
            ),
          ),
        ),

        const SizedBox(width: 14),

        /// Slider
        Stack(
          children: [
            Container(
              width: sliderWidth,
              height: 5,
              decoration: BoxDecoration(
                color: Constants.speedSliderBGColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              width: sliderWidth * sliderProgress,
              height: 5,
              decoration: BoxDecoration(
                color: Constants.addCourtTextColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),

        const SizedBox(width: 14),

        /// +
        GestureDetector(
          onTap: canAdd ? _onAdd : null,
          child: Opacity(
            opacity: canAdd ? 1.0 : 0.4,
            child: _actionButton(
              bgColor: addBg,
              image: addImg,
              imageSize: const Size(16, 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required Color bgColor,
    required String image,
    required Size imageSize,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Image.asset(
          image,
          width: imageSize.width,
          height: imageSize.height,
        ),
      ),
    );
  }
}
