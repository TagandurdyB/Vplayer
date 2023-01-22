import 'package:flutter/material.dart';

class ScaffoldProvider extends ChangeNotifier {
  Function _funcBackBtn = () {};
  void getFuncBackBtn(BuildContext context) {
    _funcBackBtn;
    Navigator.pop(context);
  }

  void changeFuncBackBtn(Function func) {
    _funcBackBtn = func;
    notifyListeners();
  }
/*
  PersistentBottomSheetController? _sheedController;
  PersistentBottomSheetController? get sheedController => _sheedController;

  void changeSheedControl(PersistentBottomSheetController control) {
    _sheedController = control;
    notifyListeners();
  }*/

  /*void showSheed(BuildContext context, GlobalKey<ScaffoldState> scafKey) {
    _sheedController =
        scafKey.currentState.showBottomSheet<Null>((context) => null);
  }*/
}
