import 'package:flutter/material.dart';
import 'package:spin_defender/constants.dart';
import 'package:spin_defender/models/month_data_model.dart';
import 'package:spin_defender/models/training_time_model.dart';
import 'package:spin_defender/training/training_data_view.dart';
import 'package:spin_defender/training/training_month_data_view.dart';
import 'package:intl/intl.dart';

import '../util/data_base.dart';
import '../util/string_util.dart';

class TrainingDataController extends StatefulWidget {
  const TrainingDataController({super.key});

  @override
  State<TrainingDataController> createState() => _TrainingDataControllerState();
}

class _TrainingDataControllerState extends State<TrainingDataController> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final now = DateTime.now();
    // 1. 当前月份英文全称
    final monthEn = DateFormat('MMMM').format(now); // January
    // 2. 当前月份有多少天
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    print('Month: $monthEn, Days: $daysInMonth');

    var todayTime = StringUtil.currentTimeString();
    var model = TrainingTimeModel(trainingTime: "40", time: todayTime);
    DataBaseHelper().insertData(kDataBaseTrainingTimeTableName, model);

    var arr = DataBaseHelper().getData(kDataBaseTrainingTimeTableName);
    print("123${arr}");

    getTodayBallNumsByDB();
  }

  // 获取这个月的训练数据
  void getTodayBallNumsByDB() async {
    final _list = await DataBaseHelper().getData(
      kDataBaseTrainingTimeTableName,
    );
    var todayTime = StringUtil.currentTimeString();
    // 先取出今日的捡球数量
    _list.forEach((element) {
      print("训练数据${element.trainingTime}--${element.time}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Constants.darkControllerColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 64),
            Constants.boldBaseTextWidget("Training", 22),
            SizedBox(height: 35),

            /// 当前月份的训练时间汇总
            Center(
              child: Container(
                width: Constants.screenWidth(context) - 32,
                // color: Constants.actionSwitchBGColor,
                decoration: BoxDecoration(
                  color: Constants.actionSwitchBGColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 100,
                child: TrainingMonthDataView(),
              ),
            ),

            SizedBox(height: 36),
            Container(
              margin: EdgeInsets.only(left: 16),
              width: Constants.screenWidth(context),
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Constants.mediumWhiteTextWidget(
                    "Training History",
                    16,
                    Colors.white,
                  ),
                  SizedBox(height: 18),

                  /// 总共的训练时间
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: TrainingDataView(
                      model: MonthDataModel("Total", "10:20:33", "+2%"),
                    ),
                  ),

                  SizedBox(height: 26),
                  Container(
                    width: Constants.screenWidth(context) - 32,
                    height: 0.5,
                    color: Color.fromRGBO(86, 86, 116, 1.0),
                  ),

                  /// 平均训练时间
                  SizedBox(height: 26),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: TrainingDataView(
                      model: MonthDataModel("Avg. Time", "00:40:30", "+2%"),
                    ),
                  ),

                  SizedBox(height: 26),
                  Container(
                    width: Constants.screenWidth(context) - 32,
                    height: 0.5,
                    color: Color.fromRGBO(86, 86, 116, 1.0),
                  ),

                  /// 最近一次的训练时间
                  SizedBox(height: 26),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: TrainingDataView(
                      model: MonthDataModel(
                        "Latest Training",
                        "00:35:01",
                        "02.10.2025",
                      ),
                    ),
                  ),
                  SizedBox(height: 26),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
