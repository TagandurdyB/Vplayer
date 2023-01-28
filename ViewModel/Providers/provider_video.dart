import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:local_player/ViewModel/Providers/provider_orientation.dart';
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
    //tongleForvardBtns;
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
  bool? get isDragUp => _isDragUp;

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
    notifyListeners();
    _closeArrowAnim();
  }

  void _dragVertical() {
    if (_isDragUp != null) {
      _isFastBtnsUse = true;
      if (_isDragUp!) {
        _tabUpward();
      } else {
        _tabDownward();
      }
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

  void _changeForwardShowTrue() {
    _isForwardBtnsShow = true;
    _closeForwardBtnsTimer();
    notifyListeners();
  }

  void get changeForwardShowTrue => _changeForwardShowTrue();
  //WillPop//////////////////////////////////////////////////////////////////

  bool _backFunc() {
    bool result = true;
    if (_isShowSheed && _isFullScreen) {
      _isFullScreen = false;
      _playerAutoSize();
      result = false;
    } else if (_isShowSheed) {
      _isShowSheed = false;
      _isFullScreen = true;
      _portraitMod();
      result = false;
    }
    notifyListeners();
    return result;
  }

  bool get backFunc => _backFunc();

  Future<bool> _willPop(BuildContext context) async {
    Future<bool> result = Future.value(false);
    if (!_isPortrait) {
      MyOrientation(context).setPortraitUp;
      _isFullScreen = true;
      _isPortrait = true;
    } else if (_backFunc()) {
      result = Future.value(true);
    }
    notifyListeners();
    return result;
  }

  Future<bool> willPop(BuildContext context) => _willPop(context);
  //Volume/////////////////////////////////////////////////////////////////////////
  double _setVolume = 50;
  double _oldVolume = 0;
  bool _isOn = true;

  void _resetVolume() {
    _setVolume = 50;
    _oldVolume = 0;
    notifyListeners();
  }

  void get resetVolume => _resetVolume();

  double get setVolume => _setVolume;
  double get oldVolume => _oldVolume;

  void changeVolume(double val) {
    _setVolume = val;
    notifyListeners();
  }

  void _tongelVolume() {
    _changeForwardShowTrue();
    _isOn = !_isOn;
    if (_isOn) {
      _setVolume = _oldVolume;
      _oldVolume = 0;
    } else {
      _oldVolume = _setVolume;
      _setVolume = 0;
    }
    notifyListeners();
  }

  void get tongleVolume => _tongelVolume();
  /////////////////////////////////////////////////////////////////////////////////
  //PlayerSize////////////////////////////////////////////////////////////////////////
  double _playerHeight = Screen().playerPortraitHeight;
  double _playerWidth = Screen().playerPortraitWidth;

  double get playerHeight => _playerHeight;
  double get playerWidth => _playerWidth;

  bool _isMinToPortrait = true;

  void _minMod() {
    _isMinToPortrait = true;
    _playerHeight = Screen().playerMinHeight;
    _playerWidth = Screen().playerMinWidth;
    notifyListeners();
  }

  void get playerMinMod => _minMod();

  void _portraitMod() {
    _playerHeight = Screen().playerPortraitHeight;
    _playerWidth = Screen().playerPortraitWidth;
    notifyListeners();
  }

  void get playerPortraitMod => _portraitMod();

  void _portraitThenMod() {
    _isForwardBtnsShow = false;
    Future.delayed(MyTimes().timeSheed).then((_) {
      _portraitMod();
      _changeForwardShowTrue();
      //   _isForwardBtnsShow=true;
    });
  }

  void get playerPortraitThenMod => _portraitThenMod();

  void _landscapeMod() {
    _isMinToPortrait = false;
    _playerHeight = Screen().playerLandscapeHeight;
    _playerWidth = Screen().playerLandscapeWidth;
    notifyListeners();
  }

  void get playerLandscapeMod => _landscapeMod();

  void _landscapeThenMod() => Future.delayed(MyTimes().timeSheed).then((_) {
        _landscapeMod();
      });

  void get playerlandscapeThenMod => _landscapeThenMod();

  void _playerAutoSize() {
    debugPrint(
        "isFull:=$_isFullScreen Portrate:=$_isPortrait  IsMinToPortrait:=$_isMinToPortrait");
    if (!_isFullScreen && _isPortrait) {
      _minMod();
    } else if (_isFullScreen && _isPortrait && !_isMinToPortrait) {
      _portraitMod();
    } else if (_isFullScreen && _isPortrait && _isMinToPortrait) {
      _portraitThenMod();
    } else if (isFullScreen && !_isPortrait) {
      _landscapeMod();
    }
    notifyListeners();
  }

  void get playerAutoSize => _playerAutoSize();

  ////////////////////////////////////////////////////////////////////////////////////
}
