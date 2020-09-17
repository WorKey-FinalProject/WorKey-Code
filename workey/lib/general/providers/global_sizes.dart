import 'package:flutter/cupertino.dart';

class GlobalSizes with ChangeNotifier {
  double _appBarHeight;

  get getAppBarHeight {
    return _appBarHeight;
  }

  void setAppBarHeight(Size size) {
    _appBarHeight = size.height;
  }
}
