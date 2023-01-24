
import 'package:flutter/material.dart';
import 'package:local_player/Model/video_model.dart';
import 'package:local_player/ViewModel/Providers/provider_theme.dart';
import '/View/Widget/my_container.dart';
import '/ViewModel/Providers/provider_video.dart';
import '/ViewModel/screen_values.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class VideoCardWidget extends StatefulWidget {
  final VideoObj obj;
  const VideoCardWidget({super.key, required this.obj});

  @override
  State<VideoCardWidget> createState() => _VideoCardWidgetState();
}

class _VideoCardWidgetState extends State<VideoCardWidget> {
  @override
  void initState() {
    super.initState();
  }

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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                      visible: widget.obj.thumbnail != null,
                      child: widget.obj.thumbnail != null
                          ? Image.memory(widget.obj.thumbnail!)
                          : const SizedBox()),
                  ProviderTheme().iconMainPlay,
                ],
              )),
          buildBottomDetal(screen, context)
        ],
      ),
    );
  }

  Widget buildBottomDetal(Screen screen, BuildContext context) {
    return Container(
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
                widget.obj.videoText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14.0, color: Colors.white),
              ),
            ),
          ),
          const Icon(
            Icons.more_vert,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  void _settingModelBottomSheed(context) {
    final providV = Provider.of<ProviderVideo>(context, listen: false);
    providV.changeShowSheed(true);
    providV.startVideo;
    providV.changeVideoObj(widget.obj);
    debugPrint("sheed open!");

  }
}
