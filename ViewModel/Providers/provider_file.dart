import 'dart:io';

import 'package:flutter/widgets.dart';

class ProviderFile extends ChangeNotifier {
  List<File> _videos = [];
  List<File> get videos => _videos;

  void changeVideos(List<File> files) {
    _videos = files;
    notifyListeners();
  }
}
