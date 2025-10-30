import 'package:flutter/material.dart';
import 'package:spin_defender/setup/setup_item_view.dart';
import 'package:spin_defender/setup/setup_model.dart';

class SetupListView extends StatefulWidget {
  List<SetupModel> datas;

  SetupListView({required this.datas});

  @override
  State<SetupListView> createState() => _SetupListViewState();
}

class _SetupListViewState extends State<SetupListView> {
  final ScrollController _ctrl = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,   // 去掉系统默认顶部 padding
        itemBuilder: (context,index){
        return GestureDetector(onTap: (){

        },
         child:SetupItemView(model: widget.datas[index],)
        );
        }, separatorBuilder: (context, index) =>   SizedBox(height: 10,),
        itemCount: widget.datas.length);
  }
}
