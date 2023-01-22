import 'package:flutter/material.dart';
import 'package:local_player/Model/video_model.dart';
import 'package:local_player/View/Widget/portrait_played_widget.dart';
import 'package:local_player/View/Widget/video_play_file_widget.dart';
import '/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/screen_values.dart';

class MyBottomVideoSheed extends StatefulWidget {
  final VideoObj obj;
  const MyBottomVideoSheed({super.key, required this.obj});

  @override
  State<MyBottomVideoSheed> createState() => _MyBottomVideoSheedState();
}

class _MyBottomVideoSheedState extends State<MyBottomVideoSheed>
    with SingleTickerProviderStateMixin {
  late AnimationController animControler;

  double sheedHight = Screen().height;

  double dragStartY = 0.0;
  double dragEndY = 0.0;

  bool isFull = true;

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
      onTap: () => Provider.of<ProviderVideo>(context, listen: false)
          .changeFullScreen(true),
      child: screenChange(),
    );
  }

  void animSheed(double sheedHightDegry) {
    final screen = Screen();
    animControler.addListener(() {
      setState(() {
        sheedHight = screen.height * (animControler.value + sheedHightDegry);
      });
    });
  }

  Widget screenChange() {
    isFull = Provider.of<ProviderVideo>(context).isFullScreen;
    if (isFull) {
      animControler.forward();
      animSheed(0);
    } else {
      animControler.reverse();
      animSheed(0.1);
    }
    return Container(
      height: sheedHight,
      width: double.infinity,
      color: Colors.blue,
      child: Stack(
        children: [
          buildVideoDrag(),
          Visibility(
            visible: !isFull,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Provider.of<ProviderVideo>(context, listen: false)
                        .changeShowSheed(false);
                    Navigator.pop(context);
                  }),
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

    /*  return Container(
      height: sheedHight,
      width: double.infinity,
      color: Colors.blue,
      child: Stack(
        children: [
          buildVideoDrag(),
        ],
      ),
    );*/
  }

  Widget buildVideoDrag() => GestureDetector(
      onVerticalDragStart: (detal) {
        dragStartY = detal.globalPosition.dy;
      },
      onVerticalDragUpdate: (detal) {
        dragEndY = detal.globalPosition.dy;
      },
      onVerticalDragEnd: (detal) {
        if (dragEndY - dragStartY > 70) {
          debugPrint(" $dragStartY    $dragEndY  ");
          Provider.of<ProviderVideo>(context, listen: false)
              .changeFullScreen(false);
        }
      },
      //child: VideoPlayerFileWidget(videoFile: widget.obj.videoFile!));
      // child: VideoPlayerFileWidget(videoFile: widget.obj.videoFile!));
      child: Container(
    //      height: isFull ? Screen().width * 0.6 : Screen().height * 0.1,
     //     width: isFull ? Screen().width : Screen().height * 0.16,
          color: Colors.black,
          child: PortraitPlayerWidget(videoFile: widget.obj.videoFile!)));
  /* child: Container(
        height: 150,
        width: 200,
        color: Colors.red,
      ));*/
}
