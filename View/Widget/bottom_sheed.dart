import 'package:flutter/material.dart';
import 'package:local_player/Model/video_model.dart';
import 'package:local_player/View/Widget/portrait_played_widget.dart';
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
  double sheedHight = Screen().height;

  double dragStartY = 0.0;
  double dragEndY = 0.0;

  bool isFull = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Provider.of<ProviderVideo>(context, listen: false)
          .changeFullScreen(true),
      child: screenChange(),
    );
  }

  void sheedHeight(double sheedHightDegry) {
    setState(() {
      sheedHight = Screen().height * sheedHightDegry;
    });
  }

  Widget screenChange() {
    isFull = Provider.of<ProviderVideo>(context).isFullScreen;
    if (isFull) {
      sheedHeight(1);
    } else {
      sheedHeight(0.1);
    }
    return Container(
      height: sheedHight,
      width: double.infinity,
      color: Colors.grey[700],
      child: Column(
        children: [
          Stack(
            children: [buildVideoDrag(), buildMinBtns()],
          ),
          buildSheedList(),
        ],
      ),
    );
  }

  Widget buildMinBtns() => Visibility(
        visible: !isFull,
        child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              bulidCloseBtn(),
            ],
          ),
        ),
      );
      
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
      child: PortraitPlayerWidget(obj: widget.obj));

  Widget bulidCloseBtn() => IconButton(
      icon: const Icon(Icons.close, color: Colors.white),
      onPressed: () {
        Provider.of<ProviderVideo>(context, listen: false)
            .changeShowSheed(false);
        Navigator.pop(context);
      });

  Widget buildSheedList() => Visibility(
      visible: isFull,
      child: Flexible(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: ((context, index) => Container(
                margin: const EdgeInsets.all(8),
                color: Colors.black,
                width: double.infinity,
                height: 100,
              )),
        ),
      ));
}
