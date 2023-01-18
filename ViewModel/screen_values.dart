double _screenWidth=100.0;
double _screenHeight=200.0;
class Screen{
double get width=>_screenWidth;
double get height=>_screenHeight;
void changeWidth(double i)=>_screenWidth=double.parse(i.toStringAsFixed(2));
void changeHeight(double i)=>_screenHeight=double.parse(i.toStringAsFixed(2));
}