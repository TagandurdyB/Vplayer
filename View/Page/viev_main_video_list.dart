import 'package:flutter/material.dart';
import 'package:local_player/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/Providers/provider_file.dart';
import '../../ViewModel/screen_values.dart';
import '../Widget/video_card_widget.dart';

// ignore: must_be_immutable
class VievMainVideoList extends StatelessWidget {
  VievMainVideoList({Key? key}) : super(key: key);

  late BuildContext contextM;

  @override
  Widget build(BuildContext context) {
    contextM = context;
    final providV = Provider.of<ProviderVideo>(context);
    return Column(
      children: [
        buildMainList(),
        Visibility(
            visible: providV.isShowSheed && !providV.isFullScreen,
            child: SizedBox(height: Screen().playerMinHeight)),
      ],
    );
  }

  Widget buildMainList() {
    final providerF = Provider.of<ProviderFile>(contextM);
    return Expanded(
      child: SizedBox(
        height: 0,
        width: double.infinity,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: providerF.videos.length,
            itemBuilder: ((context, index) {
              return VideoCardWidget(
                obj: providerF.videos[index],
              );
            })),
      ),
    );
  }
}
