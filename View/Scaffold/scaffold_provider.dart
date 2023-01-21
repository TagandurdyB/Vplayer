import 'package:flutter/widgets.dart';

class ScaffoldProvider extends ChangeNotifier {
   Function _funcBackBtn = () {};
  void  getFuncBackBtn(BuildContext context){
    _funcBackBtn;
Navigator.pop(context);
  }

  void changeFuncBackBtn(Function func) {
    _funcBackBtn = func;
    notifyListeners();
  }
}
