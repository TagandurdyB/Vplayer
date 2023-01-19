import 'package:flutter/material.dart';
import 'package:player/View/Widget/bottom_sheed.dart';
import 'package:player/View/Widget/my_container.dart';
import 'package:player/ViewModel/screen_values.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Screen();
    return MyContainer(
      onTap: () => _settingModelBottomSheed(context),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            width: screen.width,
            height: screen.width * 0.7,
          ),
          Container(
            color: Colors.grey[800],
            width: screen.width,
            height: screen.width * 0.2,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                CircleAvatar(child: Icon(Icons.ac_unit_rounded)),
                Text("salam"),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _settingModelBottomSheed(context) {
    showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return const MyBottomSheed();
        });
  }
}
