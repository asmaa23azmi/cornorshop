import 'package:flutter/material.dart';

class StyleProvider extends ChangeNotifier {

  int _index = 0;

  int get index => _index;

  set index(int i) {
    _index = i;
    notifyListeners();
  }
}
