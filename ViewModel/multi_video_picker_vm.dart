import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:local_player/Model/video_model.dart';
import 'package:local_player/ViewModel/Providers/provider_file.dart';
import 'package:local_player/ViewModel/rout_vm.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MultipleVideoPicker {
  Future<Uint8List?> getThumbnail(String path) async {
    return await VideoThumbnail.thumbnailData(
        video: path, imageFormat: ImageFormat.JPEG);
  }

  Future<void> pick(context) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: true);

    if (result != null) {

      List<VideoObj> objs = [];
      for (int i = 0; i < result.paths.length; i++) {
        final String? path = result.paths[i];
        if (path != null) {
          objs.add(VideoObj(
            fileController: VideoPlayerController.file(File(path)),
            videoPath: path,
            videoFile: File(path),
            thumbnail: await getThumbnail(path),
            videoText: path.split('/').last,
            index: i,
          ));
        }
      }

      Provider.of<ProviderFile>(context, listen: false).changeVideos(objs);
      Navigator.pushNamed(context, Rout.pageLocalPlayer);
    } else {
      debugPrint("Error!!!");
      pick(context);
    }
  }

  void repick(BuildContext context, int sec) {
    Future.delayed(Duration(seconds: sec)).then((value) => pick(context));
  }
}
