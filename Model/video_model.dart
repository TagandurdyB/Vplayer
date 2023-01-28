import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoObj {
  int index;
  final String videoUrl;
  final String videoPath;
  final String videoAsset;
  final String videoText;
  final File? videoFile;
  Uint8List? thumbnail;
  double videoWidth;
  double videoHeight;
  double videoAreaWidth;
  double videoAreaHeight;
  AspectRatio? videoAspectRatio;
  final VideoPlayerController? fileController;
  VideoObj(
      {
         this.fileController,
        this.thumbnail,
        this.videoAspectRatio,
      this.index = -1,
      this.videoWidth = 0.0,
      this.videoHeight = 0.0,
      this.videoAreaWidth = 0.0,
      this.videoAreaHeight = 0.0,
      this.videoFile,
      this.videoPath = "",
      this.videoAsset = "",
      this.videoText = "",
      this.videoUrl = ''});

  void changeWidth(double width) {
    videoAreaWidth = width;
  }

  void changeIndex(int i) {
    index = i;
  }
}
