import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

import '../../Model/video_model.dart';
import '../screen_values.dart';
import '../time_converter.dart';

class ProviderVideo extends ChangeNotifier {
  final int _forbardBtnsSec = 3;

  void _startVideo() {
    tongleForvardBtns;
    changeFullScreen(true);
    changeShowSheed(true);
    changePause(false);
    notifyListeners();
  }

  Widget _sheehChild = const SizedBox();
  Widget get sheehChild => _sheehChild;

  void changeSheedChild(Widget child) {
    _sheehChild = child;
    notifyListeners();
  }

  void get startVideo => _startVideo();

  VideoObj _obj = VideoObj();
  VideoObj get obj => _obj;
  void changeVideoObj(VideoObj ob) {
    _obj = ob;
    notifyListeners();
  }

/////////////////////////////////////////////////////////////
  bool _isFastBtnsUse = false;
  bool get isFastBtnsUse => _isFastBtnsUse;

  void changeFastBtnsUse(bool isDouble) {
    _isFastBtnsUse = isDouble;
    notifyListeners();
  }

  bool _isDoubleTabLeft = false;
  bool get isDoubleTabLeft => _isDoubleTabLeft;

  void changeDoubleTabSide(int tabX) {
    _isDoubleTabLeft = tabX < Screen().width * 0.5;
    notifyListeners();
  }

  bool _isBackward = false;
  bool get isBackward => _isBackward;

  bool _isForward = false;
  bool get isForward => _isForward;

  void _doubleTab(VideoPlayerController control) {
    _isFastBtnsUse = true;
    const Duration seekTile = Duration(seconds: 10);
    Duration position = TimeConterter(control).videoPosition;
    if (_isDoubleTabLeft) {
      _tabBackward();
      position -= seekTile;
    } else {
      _tabForward();
      position += seekTile;
    }
    control.seekTo(position);
  }

  void doubleTab(VideoPlayerController control) => _doubleTab(control);

  void _tabBackward() {
    _isBackward = true;
    notifyListeners();
    _closeTabAnim();
  }

  void get tabBackward => _tabBackward();

  void _tabForward() {
    _isForward = true;
    notifyListeners();
    _closeTabAnim();
  }

  void get tabForward => _tabForward();

  void _closeTabAnim() {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      _isBackward = false;
      _isForward = false;
      _isFastBtnsUse = false;
      notifyListeners();
    });
  }

/////////////////////////////////////////////////////////////
  bool _isPortrait = true;
  bool get isPortrait => _isPortrait;

  void _tongleOrientation() {
    _isPortrait = !_isPortrait;
    notifyListeners();
  }

  void get tongleOrientation => _tongleOrientation();

  void changeOrientation(bool isPortr) {
    _isPortrait = isPortr;
    notifyListeners();
  }

/////////////////////////////////////////////////////////////
  bool _isForwardBtnsShow = false;
  bool get isForwardBtnsShow => _isForwardBtnsShow;

  bool _isShowSheed = false;
  bool get isShowSheed => _isShowSheed;

  void changeShowSheed(bool isShow) {
    _isShowSheed = isShow;
    notifyListeners();
  }

  double _videoSheedHeight = 0.0;
  double _videoSheedMaxHeight = 0.0;
  double get videoSheedHeight => _videoSheedHeight;

  void videoSheedMaxHeight(double height) {
    _videoSheedMaxHeight = height;
    height = double.parse(height.toStringAsFixed(2));
    _videoSheedHeight = height;
    notifyListeners();
  }

  void _sheedMaxHeight() {
    _videoSheedHeight = _videoSheedMaxHeight;
    notifyListeners();
  }

  void get changeSheedMaxHeight => _sheedMaxHeight();

  void _sheedMinHeight() {
    _videoSheedHeight = Screen().width * 0.25;
    notifyListeners();
  }

  void get changeSheedMinHeight => _sheedMinHeight();

  bool _isVideoPause = false;
  bool get isVideoPause => _isVideoPause;

  void _tongleForvardBtns() {
    _isForwardBtnsShow = !_isForwardBtnsShow;
    //   if(_isVideoPause)_isForwardBtnsShow=true;
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

  void changePause(bool isPause) {
    _isVideoPause = isPause;
    notifyListeners();
  }

  void changeForwardShow(bool i) {
    _isForwardBtnsShow = i;
    notifyListeners();
  }

  bool _isFullScreen = false;
  bool get isFullScreen => _isFullScreen;

  void changeFullScreen(bool i) {
    _isFullScreen = i;
    if (_isFullScreen) {
      changeSheedMaxHeight;
    } else {
      changeSheedMinHeight;
    }
    notifyListeners();
  }
}
