import 'package:video_player/video_player.dart';

class TimeConterter {
  final VideoPlayerController controller;
  TimeConterter(this.controller);

  Duration _roundDuration(Duration value) =>
     Duration(milliseconds: value.inMilliseconds.round());
  

  Duration get videoDuration => _roundDuration(controller.value.duration);

  Duration get videoPosition => _roundDuration(controller.value.position);

  String durationToString(Duration durat) {
    String result = "00:00";
    if (videoDuration.inHours != 0) {
      result = [durat.inHours, durat.inMinutes, durat.inSeconds]
          .map((seg) => seg.remainder(60).toString().padLeft(2, "0"))
          .join(":");
    } else {
      result = [durat.inMinutes, durat.inSeconds]
          .map((seg) => seg.remainder(60).toString().padLeft(2, "0"))
          .join(":");
    }
    return result;
  }

  String _getPosition() => durationToString(videoPosition);
  String get getPosition => _getPosition();

  String _getDuration() => durationToString(videoDuration);
  String get getDuration => _getDuration();

  String get getTime => "${_getPosition()} / ${_getDuration()}";
}
