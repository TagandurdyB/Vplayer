import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            padding: EdgeInsets.all(100),
            color: Colors.black,
            child:const DemoVideoQuality()),
    );
 
  }
}

class DemoVideoQuality extends StatefulWidget {
  const DemoVideoQuality({super.key});


  @override
  _DemoVideoQualityState createState() => _DemoVideoQualityState();
}

class _DemoVideoQualityState extends State<DemoVideoQuality> {
  late VideoPlayerController _controller;
   Future<void>? _initializeVideoPlayerFuture;
  late int _playBackTime;

  //The values that are passed when changing quality
  late Duration newCurrentPosition;

  String defaultStream =
      "/data/user/0/com.example.local_player/cache/file_picker/reco7.mp4";
  String stream2 = "/data/user/0/com.example.local_player/cache/file_picker/20230110_192734.mp4";
  String stream3 =   "/data/user/0/com.example.local_player/cache/file_picker/20221218_230052.mp4";

      
    
  

  @override
  void initState() {
    _controller = VideoPlayerController.file(File(defaultStream));
    _controller.addListener(() {
      setState(() {
        _playBackTime = _controller.value.position.inSeconds;
      });
    });
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _initializeVideoPlayerFuture = null;
    _controller?.pause()?.then((_) {
      _controller.dispose();
    });
    super.dispose();
  }

  Future<bool> _clearPrevious() async {
    await _controller?.pause();
    return true;
  }

  Future<void> _initializePlay(String videoPath) async {
    _controller = VideoPlayerController.network(videoPath);
    _controller.addListener(() {
      setState(() {
        _playBackTime = _controller.value.position.inSeconds;
      });
    });
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.seekTo(newCurrentPosition);
      _controller.play();
    });
  }

  void _getValuesAndPlay(String videoPath) {
    newCurrentPosition = _controller.value.position;
    _startPlay(videoPath);
    print(newCurrentPosition.toString());
  }

  Future<void> _startPlay(String videoPath) async {
    setState(() {
      _initializeVideoPlayerFuture = null;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        _initializePlay(videoPath);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: <Widget>[
              Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.black54,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: FloatingActionButton(
                          onPressed: () {
                            // Wrap the play or pause in a call to `setState`. This ensures the
                            // correct icon is shown.
                            setState(() {
                              // If the video is playing, pause it.
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                // If the video is paused, play it.
                                _controller.play();
                              }
                            });
                          },
                          // Display the correct icon depending on the state of the player.
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          _controller.value.position
                              .toString()
                              .split('.')
                              .first
                              .padLeft(8, "0"),
                        ),
                      ),
                      Container(
                        child: TextButton(
                         // color: Colors.yellow,
                          onPressed: () {
                            _getValuesAndPlay(defaultStream);
                          },
                          child: Text('Default Stream'),
                        ),
                      ),
                      Container(
                        child: TextButton(
                        //  color: Colors.red,
                          onPressed: () {
                            _getValuesAndPlay(stream2);
                          },
                          child: Text('Video Stream 2'),
                        ),
                      ),
                      Container(
                        child: TextButton(
                        //  color: Colors.green,
                          onPressed: () {
                            _getValuesAndPlay(stream3);

                            print('Green Button');
                          },
                          child: Text('Video Stream 3'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}