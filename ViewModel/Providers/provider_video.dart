import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

import '../../Model/video_model.dart';
import '../durations_vm.dart';
import '../screen_values.dart';
import '../time_converter.dart';

class ProviderVideo extends ChangeNotifier {
  final int _forbardBtnsSec = 3;

  Widget _sheehChild = const SizedBox();
  Widget get sheehChild => _sheehChild;

  void changeSheedChild(Widget child) {
    _sheehChild = child;
    notifyListeners();
  }

  void _startVideo() {
    tongleForvardBtns;
    changeFullScreen(true);
    changeShowSheed(true);
    changePause(false);
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

  bool? _isDragUp = false;

  void changeDoubleTabSide(int tabX) {
    if (tabX < Screen().width * 0.5 && _isPortrait) {
      _isDoubleTabLeft = true;
    } else if (tabX < Screen().height * 0.5 && !_isPortrait) {
      _isDoubleTabLeft = true;
    } else {
      _isDoubleTabLeft = false;
    }
    notifyListeners();
  }

  void changeDragDirection(int dragYStart, int dragYEnd) {
    if (dragYEnd - dragYStart > 70 && _isPortrait) {
      _isDragUp = false;
    } else if (dragYStart - dragYEnd > 70 && _isPortrait) {
      _isDragUp = true;
    } else if (dragYEnd - dragYStart > 70 && !_isPortrait) {
      _isDragUp = false;
    } else if (dragYStart - dragYEnd > 70 && !_isPortrait) {
      _isDragUp = null;
    } else {
      _isDragUp = null;
    }
    notifyListeners();
  }

  bool _isBackward = false;
  bool get isBackward => _isBackward;

  bool _isForward = false;
  bool get isForward => _isForward;

  bool _isUpward = false;
  bool get isUpward => _isUpward;

  bool _isDownward = false;
  bool get isDownward => _isDownward;

  void _tabUpward() {
    _isUpward = true;
    notifyListeners();
    _closeArrowAnim();
  }

  void _tabDownward() {
    _isDownward = true;
    /* Future.delayed(MyTimes().timeArrow).then((_) {
      _isFullScreen = !_isPortrait;
      _isPortrait = true;
    });*/
    notifyListeners();
    _closeArrowAnim();
  }

  void _dragVertical() {
    _isFastBtnsUse = true;
    if (_isDragUp == null) {

    } else if (_isDragUp!) {
      _tabUpward();
    } else {
      _tabDownward();
    }
  }

  void get dragVertical => _dragVertical();

  void _doubleTab(VideoPlayerController control) {
    _isFastBtnsUse = true;
    final Duration seekTime = MyTimes().timeSeekTo;
    Duration position = TimeConterter(control).videoPosition;
    if (_isDoubleTabLeft) {
      _tabBackward();
      position -= seekTime;
    } else {
      _tabForward();
      position += seekTime;
    }
    control.seekTo(position);
  }

  void doubleTab(VideoPlayerController control) => _doubleTab(control);

  void _tabBackward() {
    _isBackward = true;
    notifyListeners();
    _closeArrowAnim();
  }

  void get tabBackward => _tabBackward();

  void _tabForward() {
    _isForward = true;
    notifyListeners();
    _closeArrowAnim();
  }

  void get tabForward => _tabForward();

  void _closeArrowAnim() {
    Future.delayed(MyTimes().timeArrow).then((value) {
      _isBackward = false;
      _isForward = false;
      _isUpward = false;
      _isDownward = false;
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
  bool _isShowSheed = false;
  bool get isShowSheed => _isShowSheed;

  void changeShowSheed(bool isShow) {
    _isShowSheed = isShow;
    notifyListeners();
  }

  bool _isFullScreen = true;
  bool get isFullScreen => _isFullScreen;

  void changeFullScreen(bool i) {
    _isFullScreen = i;
    notifyListeners();
  }

  bool _isForwardBtnsShow = false;
  bool get isForwardBtnsShow => _isForwardBtnsShow;

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
}
