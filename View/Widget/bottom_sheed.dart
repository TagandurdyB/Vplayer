import 'package:flutter/material.dart';

import 'package:player/View/Widget/video_play_asset_widget.dart';
import 'package:player/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/screen_values.dart';

class MyBottomSheed extends StatefulWidget {
  const MyBottomSheed({super.key});

  @override
  State<MyBottomSheed> createState() => _MyBottomSheedState();
}

class _MyBottomSheedState extends State<MyBottomSheed>
    with SingleTickerProviderStateMixin {
  late AnimationController animControler;

  double sheedHight = Screen().height;

  double dragStartY = 0.0;
  double dragEndY = 0.0;

  @override
  void initState() {
    super.initState();
    animControler = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    //  Provider.of<ProviderVideo>(context, listen: false).changeFullScreen(true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Provider.of<ProviderVideo>(context, listen: false)
          .changeFullScreen(true),
      child: screenChange(),
    );
  }

  Widget screenChange() {
    bool isFull =
        Provider.of<ProviderVideo>(context).isFullScreen;
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
          buildVideoDrag(),
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
        child: const VideoPlayerAssetWidget(),
      );
}
