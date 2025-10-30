import 'package:flutter/material.dart';
import 'package:spin_defender/setup/favorite/favorite_model.dart';

import '../../constants.dart';
import '../../util/dialog.dart';

class FavoriteItemView extends StatefulWidget {
  FavoriteModel model;

  FavoriteItemView({required this.model});
  @override
  State<FavoriteItemView> createState() => _FavoriteItemViewState();
}

class _FavoriteItemViewState extends State<FavoriteItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Constants.dialogBgColor,
          borderRadius: BorderRadius.circular(10)
      ),
      height: 93,
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 16),
                child:Constants.boldBaseTextWidget("${widget.model.name}", 18,textColor: Constants.saveTextColor),
              ),

              SizedBox(height: 10,),

              // 信息
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child:Constants.regularWhiteTextWidget("${widget.model.number} Pods", 12, Colors.white),
                  ),
                  SizedBox(width: 2,),

                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child:Constants.regularWhiteTextWidget("${widget.model.createTime}", 12, Colors.white),
                  ),
                ],
              ),
            ],
          ),
    );
  }

}
