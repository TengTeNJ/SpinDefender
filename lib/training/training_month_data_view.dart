import 'package:flutter/material.dart';
import 'package:spin_defender/constants.dart';
import 'package:intl/intl.dart';

class TrainingMonthDataView extends StatefulWidget {
  const TrainingMonthDataView({super.key});

  @override
  State<TrainingMonthDataView> createState() => _TrainingMonthDataViewState();
}

class _TrainingMonthDataViewState extends State<TrainingMonthDataView> {
  String currentMonth = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final now = DateTime.now();

    // 1. 当前月份英文全称
    final monthEn = DateFormat('MMMM').format(now); // January
    currentMonth = monthEn;

    // 2. 当前月份有多少天
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    print('Month: $monthEn, Days: $daysInMonth');
    setState(() {});
  }

  Color getColorByIndex(int index,int row) {
    // 默认按 0、1、2 循环 黄 / 红 / 灰
    switch (index % 3) {
      case 0:
        return Constants.ciccleYellowColor;
      case 1:
        return Constants.ciccleRedColor;
      case 2:
        return Constants.circlrGreyColor;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Constants.boldBaseTextWidget("Days Active", 16),
        SizedBox(width: 22,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Constants.mediumWhiteTextWidget(("${currentMonth}."), 10 , Colors.white),
            SizedBox(height: 10,),
            Column(                       // 三行
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(3, (row) =>   // 3 行
              Padding(
                padding: const EdgeInsets.only(bottom: 10), // 行间距
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(10, (i) =>   // 10 个圆
                  Padding(
                    padding: const EdgeInsets.only(right: 10), // 圆间距
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration:  BoxDecoration(
                        color: getColorByIndex(i,row),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  ),
                ),
              ),
              ),
            )
          ],
        )
      ],
    );
  }
}
