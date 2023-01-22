import 'dart:io';

import 'package:flutter/widgets.dart';

class VideoObj {
  final String videoUrl;
  final String videoPath;
  final String videoAsset;
  final String videoText;
  final File? videoFile;
   double videoWidth;
   double videoHeight;
   double videoAreaWidth;
   double videoAreaHeight;
   AspectRatio? videoAspectRatio;
  VideoObj(
      {this.videoAspectRatio,
      this.videoWidth = 0.0,
      this.videoHeight = 0.0,
      this.videoAreaWidth = 0.0,
      this.videoAreaHeight = 0.0,
      this.videoFile,
      this.videoPath = "",
      this.videoAsset = "",
      this.videoText = "",
      this.videoUrl = ""});
}
