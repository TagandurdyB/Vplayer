class TimeConterter{

  static Duration getDuration(Duration value) {
    return Duration(milliseconds: value.inMilliseconds.round());
  }

  static String durationToString(Duration position, Duration duration) {
    String result = "00:00";
    if (duration.inHours != 0) {
      result = [position.inHours, position.inMinutes, position.inSeconds]
          .map((seg) => seg.remainder(60).toString().padLeft(2, "0"))
          .join(":");
    } else {
      result = [position.inMinutes, position.inSeconds]
          .map((seg) => seg.remainder(60).toString().padLeft(2, "0"))
          .join(":");
    }
    return result;
  }

}