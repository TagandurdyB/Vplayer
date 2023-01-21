import 'package:flutter/material.dart';
import 'package:local_player/Model/video_model.dart';
import 'package:local_player/ViewModel/Providers/provider_file.dart';
import 'package:local_player/ViewModel/Providers/provider_video.dart';
import 'package:local_player/ViewModel/multi_video_picker_vm.dart';
import 'package:provider/provider.dart';
import '/View/Widget/video_card_widget.dart';
import '../Scaffold/scaffold_all.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    final providerF = Provider.of<ProviderFile>(context);

    return ScaffoldAll(
        funcBackBtn: () {
          if (!Provider.of<ProviderVideo>(context, listen: false)
              .isVideoWork) {
            MultipleVideoPicker().repick(context, 2);
          } else {
            Navigator.pop(context);
          }
        },
        body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: providerF.videos.length,
            itemBuilder: ((context, index) {
              final file = providerF.videos[index];
              return VideoCardWidget(
                //aboutText: obj.path,
                obj: VideoObj(videoText: file.path, videoFile: file),
              );
            })));
  }
}
