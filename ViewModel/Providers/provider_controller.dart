import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:local_player/ViewModel/Providers/provider_file.dart';
import 'package:video_player/video_player.dart';

VideoPlayerController _videoController = VideoPlayerController.network("");

class ControlVideo extends ChangeNotifier {
///////////////////////////////////////////////////////////////

static const List<double> allSpeeds=[0.25,0.5,1,1.5,2,3,5,10];

double _selectSpeed=1;
double get selectSpeed=>_selectSpeed;

void _resetSpeed(){
  _selectSpeed=1;
notifyListeners();
}
void get resetSpeed=>_resetSpeed();


void _getSpeed(){
  _selectSpeed=_videoController.value.playbackSpeed;
notifyListeners();
}
void get getSpeed=>_getSpeed();

void changeSpeed(double speed){
  _selectSpeed=speed;
  notifyListeners();
}

  VideoPlayerController get control => _videoController;

 /* void changeFileControl(File file) {
    _videoController = VideoPlayerController.file(file);
    notifyListeners();
  }*/

  void startVideo(File file) {
    _dispose();
    _videoController = VideoPlayerController.file(file)
      ..initialize().then((value) => _play())
     // ..setLooping(true)
      ..setVolume(0.5)
      ..addListener(() {});
    notifyListeners();
  }



  void _dispose() {
    if (_videoController.value.isInitialized) {
      _videoController.dispose();
      notifyListeners();
    }
  }

  void get dispos => _dispose();

  void nextPlay(File file) => _startPlay(file);

  Future<void> _startPlay(File file) async {
    _clearPrevious().then((_) {
      startVideo(file);
    });
  }

  Future<bool> _clearPrevious() async {
    _pause();
    _videoController.notifyListeners();
    _dispose();
    notifyListeners();
    return true;
  }

  Future<bool> get clearPrevious => _clearPrevious();

  void _pause() {
    _videoController.pause();
    notifyListeners();
  }

  void get pause => _pause();

  void _play() {
    _videoController.play();
    notifyListeners();
  }

  void get play => _play();

///////////////////////////////////////////////////////////////

}
