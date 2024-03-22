import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../domain/forecast.dart';

class LineChartProvider extends ChangeNotifier {
  LineChartData? lineChartData;

  void setLineChartDataRaw(LineChartData? lineChartData) {
    lineChartData = lineChartData;
    notifyListeners();
  }

  void setLineChartData(List<Forecast> forecasts) {
    lineChartData = null;
    double minX = 0;
    double minY = double.infinity;
    double maxX = forecasts.length - 1;
    double maxY = double.negativeInfinity;
    List<FlSpot> flSpots = [];

    for (int i = 0; i < forecasts.length; i++) {
      if (forecasts[i].dailyValue is String) {
        return;
      }
      if (forecasts[i].dailyValue > maxY) maxY = forecasts[i].dailyValue;
      if (forecasts[i].dailyValue < minY) minY = forecasts[i].dailyValue;
      flSpots.add(FlSpot(i as double, forecasts[i].dailyValue));
    }

    lineChartData = LineChartData(
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.2),
        ),
      ),
      gridData: const FlGridData(show: true),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.pink.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      ),
      titlesData: const FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: 1,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 40,
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          isCurved: false,
          color: Colors.black,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: flSpots,
        )
      ],
      minX: minX,
      maxX: maxX,
      maxY: maxY,
      minY: minY,
    );

    notifyListeners();
  }
}
