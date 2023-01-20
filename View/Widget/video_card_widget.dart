import 'package:flutter/material.dart';
import 'package:player/View/Widget/bottom_sheed.dart';
import 'package:player/View/Widget/my_container.dart';
import 'package:player/ViewModel/Providers/provider_video.dart';
import 'package:player/ViewModel/screen_values.dart';
import 'package:provider/provider.dart';

class VideoCardWidget extends StatelessWidget {
  final String aboutText;
  const VideoCardWidget({super.key, this.aboutText = ""});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(child: Icon(Icons.ac_unit_rounded)),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      aboutText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14.0),
                    ),
                  ),
                ),
                const Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _settingModelBottomSheed(context) {
    Provider.of<ProviderVideo>(context, listen: false).changeForwardShow(true);
    showBottomSheet(
        enableDrag: false,
        
        context: context,
        builder: (BuildContext context) {
          return const MyBottomSheed();
        });
  }
}
