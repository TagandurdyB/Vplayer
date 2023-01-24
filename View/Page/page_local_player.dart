import 'package:flutter/material.dart';
import 'package:local_player/View/Page/viev_main_video_list.dart';
import 'package:local_player/View/Page/view_video_sheed.dart';
import 'package:local_player/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';
import '../Scaffold/scaffold_all.dart';

// ignore: must_be_immutable
class LocalPlayerPage extends StatelessWidget {
  LocalPlayerPage({super.key});

  double height = 0.0;

  @override
  Widget build(BuildContext context) {
    final providV = Provider.of<ProviderVideo>(context);
    final isShow = providV.isShowSheed;
    return ScaffoldAll(
        funcBackBtn: isShow ? () => providV.changeShowSheed(false) : null,
        body: LayoutBuilder(
          builder: (context, constraints) {
            height = constraints.maxHeight;
            return buildBody(context);
          },
        ));
  }

  Widget buildBody(BuildContext context) {
    final providV = Provider.of<ProviderVideo>(context);
    return Column(
      children: [
        const VievMainVideoList(),
        Visibility(
            visible: providV.isShowSheed,
            child: ViewVideoSheed(bodyMaxHeight: height)),
      ],
    );
  }
}
