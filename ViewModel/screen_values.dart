double _screenWidth = 100.0;
double _screenHeight = 0.0;
double _videoWidth = 0.0;
double _videoHeight = 0.0;
double _playerWidth = 0.0;
double _playerHeight = 0.0;

class Screen {
  double _roundSize(d) {
    return double.parse(d.toStringAsFixed(2));
  }

  double get width => _screenWidth;
  double get height => _screenHeight;
  void changeWidth(double i) => _screenWidth = _roundSize(i);
  void changeHeight(double i) => _screenHeight = _roundSize(i);
/*
  double get videowidth => _videoWidth;
  double get videoHeight => _videoHeight;
  void changeVideoWidth(double i) => _videoWidth = _roundSize(i);
  void changeVideoHeight(double i) => _videoHeight = _roundSize(i);

  double get playerWidth => _playerWidth;
  double get playerHeight => _playerHeight;
  void changePlayerWidth(double i) => _playerWidth = _roundSize(i);
  void changePlayerHeight(double i) => _playerHeight = _roundSize(i);
*/


  double get playerMinWidth => _screenWidth*0.4;
  double get playerMinHeight => _screenWidth*0.25;

  double get playerMaxWidth => _screenWidth;
  double get playerMaxHeight => _screenWidth*0.6;

  double get playerLandscapeWidth => _screenWidth*1.6;
  double get playerLandscapeHeight => _screenWidth;

}
