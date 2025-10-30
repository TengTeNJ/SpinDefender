import 'package:flutter/material.dart';
import 'package:spin_defender/setup/favorite/favorite_item_view.dart';
import 'package:spin_defender/setup/favorite/favorite_model.dart';

class FavoriteListViewu extends StatefulWidget {
  List<FavoriteModel> datas;


  FavoriteListViewu({required this.datas});

  @override
  State<FavoriteListViewu> createState() => _FavoriteListViewuState();
}

class _FavoriteListViewuState extends State<FavoriteListViewu> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,   // 去掉系统默认顶部 padding
        itemBuilder: (context,index){
          return GestureDetector(onTap: (){

          },
              child:FavoriteItemView(model: widget.datas[index],)
          );
        }, separatorBuilder: (context, index) =>SizedBox(
      height: 10,
    ), itemCount: widget.datas.length);

  }
}
