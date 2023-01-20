import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class ProviderVideo extends ChangeNotifier {
  final int _forbardBtnsSec = 3;

  bool _isForwardBtnsShow = false;
  bool get isForwardBtnsShow => _isForwardBtnsShow;

  bool _isVideoPause = false;
  bool get isVideoPause => _isVideoPause;

  bool _isFullScreen = true;
  bool get isFullScreen => _isFullScreen;

  void _tongleForvardBtns() {
    _isForwardBtnsShow = !_isForwardBtnsShow;
    if (_isForwardBtnsShow) _closeForwardBtnsTimer();
    notifyListeners();
  }

  void get tongleForvardBtns => _tongleForvardBtns();
  void _closeForwardBtnsTimer() =>
      Future.delayed(Duration(seconds: _forbardBtnsSec)).then((value) {
        if (!_isVideoPause) _isForwardBtnsShow = false;
      });

  void _tonglePause() {
    _isVideoPause = !_isVideoPause;
    if (!_isVideoPause) _closeForwardBtnsTimer();
    notifyListeners();
  }

  void get tonglePause => _tonglePause();

  void changeForwardShow(bool i) {
    _isForwardBtnsShow = i;
    notifyListeners();
  }

  void changeFullScreen(bool i) {
    _isFullScreen = i;
    notifyListeners();
  }
}
