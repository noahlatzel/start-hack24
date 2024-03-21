import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_hack/features/map/repository/forecast_result_provider.dart';

import '../domain/forecast.dart';

class ForecastWidget extends StatefulWidget {
  const ForecastWidget({super.key});

  @override
  State<ForecastWidget> createState() => _ForecastWidgetState();
}

class _ForecastWidgetState extends State<ForecastWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          items: <String>['Daily Forecast', 'Hourly Forecast', 'Nowcast']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        ),
        Consumer<ForecastResultProvider>(
          builder: (BuildContext context, ForecastResultProvider value,
              Widget? child) {
            if(value.forecastResult.isEmpty) return Container();
            final Set<String> measurableLabels = {};
            for(Forecast forecast in value.forecastResult) {
              measurableLabels.add(forecast.measureLabel);
            }
            return DropdownButton<String>(
              items: measurableLabels.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {
                List<Forecast> temp = Provider.of<ForecastResultProvider>(context, listen: false).getFilteredForecastResults(_!);
                for(Forecast forecast in temp) {
                  print(forecast.dailyValue);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
