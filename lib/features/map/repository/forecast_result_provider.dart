import 'package:flutter/material.dart';

import '../domain/forecast.dart';

class ForecastResultProvider extends ChangeNotifier {
  List<Forecast> forecastResult = [];

  void setForecastResults(List<Forecast> forecastResult) {
    this.forecastResult = forecastResult;
    print(forecastResult.length);
    notifyListeners();
  }

  List<Forecast> getFilteredForecastResults(String measureLabel) {
    return forecastResult
        .where((element) => element.measureLabel == measureLabel)
        .toList();
  }
}
