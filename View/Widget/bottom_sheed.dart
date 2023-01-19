import 'package:flutter/material.dart';

import 'package:player/View/Widget/video_play_asset_widget.dart';

import '../../ViewModel/screen_values.dart';

class MyBottomSheed extends StatefulWidget {
  const MyBottomSheed({super.key});

  @override
  State<MyBottomSheed> createState() => _MyBottomSheedState();
}

class _MyBottomSheedState extends State<MyBottomSheed>
    with SingleTickerProviderStateMixin {
  bool _isFullScreen = true;
  late AnimationController animControler;

  double sheedHight = Screen().height;

  @override
  void initState() {
    super.initState();
    animControler = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: (DragDownDetails details) {
        setState(() {
          // _isFullScreen = false;
        });
      },
      onTap: (() => setState(() {
            _isFullScreen = true;
          })),
      child: screenChange(_isFullScreen),
    );
  }

  Widget screenChange(bool isFull) {
    final screen = Screen();
    if (isFull) {
      animControler.forward();
      animControler.addListener(() {
        setState(() {
          sheedHight = screen.height * animControler.value;
        });
      });
    } else {
      animControler.reverse();
      animControler.addListener(() {
        setState(() {
          sheedHight = screen.height * (animControler.value + 0.1);
        });
      });
    }
    return Container(
      height: sheedHight,
      color: Colors.blue,
      child: Stack(
        children: [
          const VideoPlayerAssetWidget(
              //  width: isFull ? screen.width : 80,
              // height: isFull ? screen.width * 0.7 : 40,
              ),
          Visibility(
            visible: !isFull,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          /*Visibility(
              visible: isFull,
              child: Flexible(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: ((context, index) => Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        color: Colors.orange,
                        width: double.infinity,
                        height: 100,
                      )),
                ),
              ))*/
        ],
      ),
    );
  }
}
