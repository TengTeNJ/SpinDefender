import 'package:flutter/material.dart';
import 'package:spin_defender/constants.dart';
import 'package:spin_defender/models/month_data_model.dart';

class TrainingDataView extends StatefulWidget {
  MonthDataModel model;

  TrainingDataView({required this.model});

  @override
  State<TrainingDataView> createState() => _TrainingDataViewState();
}

class _TrainingDataViewState extends State<TrainingDataView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constants.mediumWhiteTextWidget("${widget.model.titleStr}", 16, Constants.baseGreyStyleColor),
        SizedBox(height: 8,),
        Constants.mediumWhiteTextWidget("${widget.model.timeStr}", 40, Colors.white),
        SizedBox(height: 8,),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Constants.mediumWhiteTextWidget("${widget.model.desc}", 14,
                widget.model.titleStr == "Latest Training" ?
               Constants.speedTextColor
               : widget.model.titleStr == "Total"  ?
                    Color.fromRGBO(91, 204, 106, 1.0)
            : Color.fromRGBO(227, 62, 62, 1.0)
            ),
            SizedBox(width: 5,),
            widget.model.titleStr == "Total" ?
            Image.asset("images/home/rise_icon.png",width: 6.23,height: 7.5,)
            : widget.model.titleStr == "Latest Training" ?
            Container() :
            Image.asset("images/home/drop_icon.png",width: 6.23,height: 7.5,)
          ],
        )
      ],
    );
  }
}
