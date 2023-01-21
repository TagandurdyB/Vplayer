import 'package:flutter/material.dart';
import 'package:local_player/Model/video_model.dart';
import 'package:local_player/ViewModel/Providers/provider_theme.dart';
import '/View/Widget/bottom_sheed.dart';
import '/View/Widget/my_container.dart';
import '/ViewModel/Providers/provider_video.dart';
import '/ViewModel/screen_values.dart';
import 'package:provider/provider.dart';

class VideoCardWidget extends StatelessWidget {
  final VideoObj obj;
  const VideoCardWidget({super.key, required this.obj});

  @override
  Widget build(BuildContext context) {
    final screen = Screen();
    return MyContainer(
      onTap: () => _settingModelBottomSheed(context),
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              color: Colors.black,
              width: screen.width,
              height: screen.width * 0.6,
              child: ProviderTheme().iconMainPlay),
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
                      obj.videoText,
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
    final providerV=
    Provider.of<ProviderVideo>(context, listen: false);
    providerV.changeForwardShow(true);
    providerV.changeFullScreen(true);
    providerV.changeVideoWork(true);
    debugPrint("sheed open!");
    showBottomSheet(
        enableDrag: false,
        context: context,
        builder: (BuildContext context) {
          return MyBottomSheed(obj: obj);
        });
  }
}
