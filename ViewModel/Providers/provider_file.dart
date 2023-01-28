
import 'package:flutter/widgets.dart';
import 'package:local_player/Model/video_model.dart';


 
class ProviderFile extends ChangeNotifier {
   List<VideoObj> _videos = [];
  List<VideoObj> get videos => _videos;

  void changeVideos(List<VideoObj> objs) {
    _videos =objs;
    notifyListeners();
  }
}
