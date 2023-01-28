import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_player/View/Page/viev_main_video_list.dart';
import 'package:local_player/View/Page/view_video_sheed.dart';
import 'package:local_player/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';
import '../Scaffold/scaffold_all.dart';

// ignore: must_be_immutable
class LocalPlayerPage extends StatelessWidget {
  const LocalPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final providV = Provider.of<ProviderVideo>(context);
    final isShow = providV.isShowSheed;
    return WillPopScope(
      onWillPop: () => providV.willPop(context),
      child: ScaffoldAll(
          funcBackBtn: isShow ? () => providV.backFunc : null,
          body: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    final providV = Provider.of<ProviderVideo>(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // offstage: !providV.isFullScreen,
        VievMainVideoList(),
        Offstage(offstage: !providV.isShowSheed, child: const ViewVideoSheed()),
      ],
    );
  }
}
