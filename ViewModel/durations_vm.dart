import 'package:flutter/widgets.dart';
import 'package:local_player/Model/duration_model.dart';

class MyTimes extends ChangeNotifier {
  Duration get timeSheed => MyDurations.timeSheedAnim;
  Duration get timePlayer => MyDurations.timePlayerAnim;
  Duration get timeArrow => MyDurations.timeArrowAnim;
  Duration get timeSeekTo => MyDurations.timeSeekTo;
}
