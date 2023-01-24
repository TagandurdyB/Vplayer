import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ProviderOrientation extends ChangeNotifier {
  Future<void> _setPortraitUp() async {
    await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    notifyListeners();
  }

  void get setPortraitUp => _setPortraitUp;

  Future<void> _setLandscapeBouth() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    notifyListeners();
  }

  void get setLandscapeBouth => _setLandscapeBouth;
}
