import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../constants.dart';

class FullScreenVideo extends StatefulWidget {
  const FullScreenVideo({super.key});

  @override
  State<FullScreenVideo> createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  String imagePath = "images/home/full_screen_stop_icon.png";

  @override
  void initState() {
    super.initState();
    // 横屏 + 隐藏系统栏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // _controller = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    // );

    _controller = VideoPlayerController.asset('images/home/demo.mp4');

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    // 恢复竖屏 + 显示系统栏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),

                Positioned(
                  left: 33,
                  top: 33,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "images/home/left_arrow_icon.png",
                      width: 36,
                      height: 36,
                    ),
                  ),
                ),

                // 暂停 播放按钮
                Positioned(
                  left: 24,
                  bottom: 38,
                  child: GestureDetector(
                    onTap: () {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                        imagePath = "images/home/full_screen_stop_icon.png";
                      } else {
                        _controller.play();
                        imagePath = "images/home/full_screen_play_icon.png";
                      }
                      setState(() {});
                    },
                    child: Image.asset(
                      "${imagePath}",
                      width: 36,
                      height: 36,
                    ),
                  ),
                ),

                // 3. 底部进度条 + 总时长 / 当前时长
                Positioned(
                  left: 94,
                  right: 94,
                  bottom: 32,
                  height: 60,
                  child: ColoredBox(
                    color: Color.fromRGBO(100, 100, 100, 0.8), // 半透明背景
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // 时长文字
                        Padding(
                          padding: const EdgeInsets.fromLTRB(26, 8, 26, 12),
                          child: Row(
                            children: [
                              // 当前时间
                              ValueListenableBuilder<VideoPlayerValue>(
                                valueListenable: _controller,
                                builder:
                                    (_, value, __) => Text(
                                  _formatDuration(value.position),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontFamily: "SanFranciscoDisplay"
                                  ),
                                ),
                              ),
                              const Spacer(),
                              // 总时长
                              Text(
                                _formatDuration(_controller.value.duration),
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                    fontFamily: "SanFranciscoDisplay"
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 可拖动的进度条
                        Container(
                          child:ClipRRect(
                            borderRadius:BorderRadius.circular(20),
                            child: VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true, // 允许拖拽
                              padding: EdgeInsets.only(left: 24,right: 24,top: 0,bottom: 14),
                              // const EdgeInsets.symmetric(horizontal: 24),
                              colors: VideoProgressColors(
                                playedColor: const Color.fromRGBO(54, 186, 255, 1.0),
                                bufferedColor: Colors.white24,
                                backgroundColor: Color.fromRGBO(214, 214, 214, 1.0),
                              ),
                            ),
                          )
                        )




                        // CupertinoVideoProgressBar(
                        //   _controller,
                        //   onDragEnd: () {
                        //     // 可选：拖动结束再播放
                        //     if (!_controller.value.isPlaying) _controller.play();
                        //   },
                        //   barHeight: 3,
                        //   handleHeight: 6,      // 小圆点直径
                        //   drawShadow: true,     // 滑块阴影
                        //   colors: const VideoProgressColors(
                        //     playedColor: Colors.white,
                        //     bufferedColor: Colors.white24,
                        //     backgroundColor: Colors.white12,
                        //     handleColor: Colors.white,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),


      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       if (_controller.value.isPlaying) {
      //         _controller.pause();
      //       } else {
      //         _controller.play();
      //       }
      //     });
      //   },
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
