import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_player/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';

class ProviderOrientation extends ChangeNotifier {
  Future<void> _setPortraitUp() async {
    await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    notifyListeners();
  }

  void get setPortraitUp => _setPortraitUp();

  Future<void> _setLandscapeBouth() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      //DeviceOrientation.portraitUp,
    ]);
    notifyListeners();
  }

  void get setLandscape => _setLandscapeBouth();
}

class MyOrientation {
  final BuildContext context;
  MyOrientation(this.context);
  void _setPortraitUp() {
    Provider.of<ProviderOrientation>(context, listen: false).setPortraitUp;
    Provider.of<ProviderVideo>(context, listen: false).changeOrientation(true);
    Provider.of<ProviderVideo>(context,listen: false).playerAutoSize;
  }

  void get setPortraitUp => _setPortraitUp();

  Future<void> _setPortraitUpDispose() async {
    await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void get setPortraitUpDispose => _setPortraitUpDispose();

  void _setLandscape() {
    Provider.of<ProviderOrientation>(context, listen: false).setLandscape;
    Provider.of<ProviderVideo>(context, listen: false).changeOrientation(false);
    Provider.of<ProviderVideo>(context,listen: false).playerAutoSize;
  }

  void get setLandscape => _setLandscape();
}
