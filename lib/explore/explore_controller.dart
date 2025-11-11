import 'package:flutter/material.dart';
import 'package:spin_defender/explore/explore_list_view.dart';

import '../constants.dart';
import '../setup/setup_model.dart';

import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';
import 'dart:io';

import '../util/common_tool.dart';

class ExploreController extends StatefulWidget {
  const ExploreController({super.key});

  @override
  State<ExploreController> createState() => _ExploreControllerState();
}

class _ExploreControllerState extends State<ExploreController> {
  List<SetupModel> data = [
    SetupModel('images/profile/setting_ball_type.png','Ball Type',true),
    SetupModel('images/profile/setting_roller_speed.png','Roller Speed',false),
    SetupModel('images/profile/setting_roller_speed.png','Roller Speed',false),
  ];

  late final String videoPath;   // 本地视频路径
  Uint8List? thumbData;          // 内存封面
  File? thumbFile;               // 文件封面

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _prepareVideo().then((_) => _generateThumbnails());
  }

  Future<void> _prepareVideo() async {
    // final docDir = await getApplicationDocumentsDirectory();
    videoPath = 'images/home/demo.mp4';

    // 如果文档目录还没有视频，就从 assets 复制一份
    final videoFile = File(videoPath);
    if (!await videoFile.exists()) {
      final byteData = await DefaultAssetBundle.of(context)
          .load('images/home/demo.mp4');
      await videoFile.writeAsBytes(byteData.buffer.asUint8List());
    }
  }

  Future<void> _generateThumbnails() async {
    thumbData = await generateThumbData(videoPath);
    thumbFile = await generateThumbFile(videoPath);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Constants.darkControllerColor,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 48,),
              Constants.boldWhiteTextWidget("Explore", 22),
              SizedBox(height: 24,),
              Container(
                padding: EdgeInsets.only(left: 24,right: 24,bottom: 24),
                // color: Colors.red,
                width: Constants.screenWidth(context),
                height: Constants.screenHeight(context) - 160,
                child:ExploreListView(datas: data) ,
              ),
              SizedBox(height: 48,),
            ],
          ),
        ),
      ),
    );
  }
}
