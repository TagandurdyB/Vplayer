import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDemoNext extends StatefulWidget {
  @override
  _VideoDemoNextState createState() => _VideoDemoNextState();
}

class _VideoDemoNextState extends State<VideoDemoNext> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    _initializePlay();
    super.initState();
  }

  void _nextVideoPlay(String videoPath) {
    ///
    _startPlay(videoPath);
  }

  Future<void> _startPlay(String videoPath) async {
    await _clearPrevious().then((_) {
      _initializePlay(videoPath: videoPath);
    });
  }

  Future<bool> _clearPrevious() async {
    await _videoController.pause();
    _videoController.notifyListeners();
    _videoController.dispose();
    return true;
  }

  Future<void> _initializePlay({String? videoPath}) async {
    _videoController = VideoPlayerController.file(
        videoPath != null ? File(videoPath) : File(AppResource.videos.first))
      ..initialize().then((_) {
        _videoController.play();
        setState(() {});
      });
  }

  int videoIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: _videoController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  )
                : Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: 200,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
          ),
          ElevatedButton(
            onPressed: () {
              videoIndex += 1;
              _nextVideoPlay(
                  AppResource.videos[videoIndex % AppResource.videos.length]);
            },
            child: const Text('NEXT'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          setState(() {
            _videoController.value.isPlaying
                ? _videoController.pause()
                : _videoController.play();
          });
        },
        child: Icon(
          _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
}

class AppResource {
  static List<String> videos = [
    /*'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',*/
    "/data/user/0/com.example.local_player/cache/file_picker/reco7.mp4",
    "/data/user/0/com.example.local_player/cache/file_picker/20230110_192734.mp4",
    "/data/user/0/com.example.local_player/cache/file_picker/20221218_230052.mp4"
  ];
}
