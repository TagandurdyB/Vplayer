import 'dart:io';

class VideoObj {
  final String videoUrl;
  final String videoPath;
  final String videoAsset;
  final String videoText;
  final File? videoFile;
  VideoObj(
      {this.videoFile,
      this.videoPath = "",
      this.videoAsset = "",
      this.videoText = "",
      this.videoUrl = ""});
}
