import 'package:flutter/material.dart';

class ExtendedViewProvider extends ChangeNotifier {
  bool _extendedResults = false;

  bool get extendedResults => _extendedResults;

  set extendedResults(bool value) {
    _extendedResults = value;
    notifyListeners();
  }

  void toggle() {
    _extendedResults = !_extendedResults;
    notifyListeners();
  }
}