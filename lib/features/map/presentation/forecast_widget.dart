import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:start_hack/features/map/repository/forecast_result_provider.dart';
import 'package:start_hack/features/map/repository/latlong_provider.dart';
import 'package:start_hack/features/map/repository/line_chart_provider.dart';

import '../domain/forecast.dart';
import '../repository/syngenta_api_repository.dart';

class ForecastWidget extends StatefulWidget {
  const ForecastWidget({super.key});

  @override
  State<ForecastWidget> createState() => _ForecastWidgetState();
}

class _ForecastWidgetState extends State<ForecastWidget> {
  String dropdownButtonValue1 = 'Daily Forecast';
  String dropdownButtonValue2 = '';
  bool trigger = false;

  @override
  Widget build(BuildContext context) {
    LatLng? currentLocation = Provider.of<LatLongProvider>(context).coordinates;
    return currentLocation == null
        ? const Text("Please select a location first.")
        : Column(
            children: [
              Text(
                  'You selected a location at ${currentLocation.latitude.toStringAsFixed(2)}, ${currentLocation.longitude.toStringAsFixed(2)}.\nWhich forecast method do you want to use?'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: dropdownButtonValue1,
                    items: <String>[
                      'Daily Forecast',
                      'Hourly Forecast',
                      'Nowcast'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {
                      if(_! != dropdownButtonValue1) {
                        setState(() {
                          dropdownButtonValue1 = _;
                        });
                        Provider.of<ForecastResultProvider>(context,
                            listen: false)
                            .setForecastResults([]);
                      }
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<ForecastResultProvider>(context,
                                listen: false)
                            .setForecastResults([]);
                        switch (dropdownButtonValue1) {
                          case 'Daily Forecast':
                            Provider.of<HttpSyngentaRepository>(context,
                                    listen: false)
                                .getShortRangeForecastDaily(
                                    "json",
                                    "Meteoblue",
                                    "2024-03-20",
                                    "",
                                    "TempAir_DailyAvg%20(C);TempAir_DailyMax%20(C);TempAir_DailyMin%20(C);Precip_DailySum%20(mm);WindDirection_DailyAvg%20(Deg);WindSpeed_DailyAvg%20(m/s);HumidityRel_DailyAvg%20(pct);WindDirection_DailyAvg;Soilmoisture_0to10cm_DailyAvg%20(vol%25);WindGust_DailyMax%20(m/s);Referenceevapotranspiration_DailySum%20(mm);TempSurface_DailyAvg%20(C);Soiltemperature_0to10cm_DailyAvg%20(C)",
                                    currentLocation.latitude,
                                    currentLocation.longitude)
                                .then((value) {
                              Provider.of<ForecastResultProvider>(context,
                                      listen: false)
                                  .setForecastResults(value);
                            });
                          case 'Hourly Forecast':
                            Provider.of<HttpSyngentaRepository>(context,
                                    listen: false)
                                .getShortRangeForecastHourly(
                                    "json",
                                    "Meteoblue",
                                    "2024-03-20",
                                    "",
                                    "Precip_HourlySum%20%28mm%29%3BPrecipProbability_Hourly%20%28pct%29%3BShowerProbability_Hourly%20%28pct%29%3BSnowFraction_Hourly%3BSunshineDuration_Hourly%20%28min%29%3BTempAir_Hourly%20%28C%29%3BVisibility_Hourly%20%28m%29%3BWindDirection_Hourly%20%28Deg%29%3BWindGust_Hourly%20%28m%2Fs%29%09%3BWindSpeed_Hourly%20%28m%2Fs%29%3BSoilmoisture_0to10cm_Hourly%20%28vol%25%29%3BSoiltemperature_0to10cm_Hourly%20%28C%29",
                                    currentLocation.latitude,
                                    currentLocation.longitude)
                                .then((value) {
                              Provider.of<ForecastResultProvider>(context,
                                      listen: false)
                                  .setForecastResults(value);
                            });
                          case 'Nowcast':
                            Provider.of<HttpSyngentaRepository>(context,
                                    listen: false)
                                .getNowcast(
                                    "json",
                                    "Meteoblue",
                                    "2024-03-20",
                                    "",
                                    "Temperature_15Min%20%28C%29%3BWindSpeed_15Min%20%28m%2Fs%29%3BWindDirection_15Min%3BHumidityRel_15Min%20%28pct%29",
                                    currentLocation.latitude,
                                    currentLocation.longitude)
                                .then((value) {
                              Provider.of<ForecastResultProvider>(context,
                                      listen: false)
                                  .setForecastResults(value);
                            });
                        }
                        trigger = false;
                      },
                      child: const Text("Get Forecast!"))
                ],
              ),
              Consumer<ForecastResultProvider>(
                builder: (BuildContext context, ForecastResultProvider value,
                    Widget? child) {
                  if (value.forecastResult.isEmpty) return Container();
                  final Set<String> measurableLabels = {};
                  for (Forecast forecast in value.forecastResult) {
                    if (forecast.dailyValue is double) {
                      measurableLabels.add(forecast.measureLabel);
                    }
                  }
                  if (!trigger) {
                    dropdownButtonValue2 = measurableLabels.first;
                    trigger = true;
                  }
                  return Column(
                    children: [
                      const Text("We gathered the following forecasts for you. Which metric do you want to see?"),
                      DropdownButton<String>(
                        value: dropdownButtonValue2,
                        items: measurableLabels.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {
                          List<Forecast> temp = Provider.of<ForecastResultProvider>(
                                  context,
                                  listen: false)
                              .getFilteredForecastResults(_!);
                          Provider.of<LineChartProvider>(context, listen: false)
                              .setLineChartData(temp);
                          setState(() {
                            dropdownButtonValue2 = _;
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
              Consumer<LineChartProvider>(
                builder: (BuildContext context, LineChartProvider value,
                    Widget? child) {
                  if (value.lineChartData != null) {
                    return Consumer<ForecastResultProvider>(
                      builder: (BuildContext context,
                          ForecastResultProvider value2, Widget? child) {
                        return value2.forecastResult.isEmpty
                            ? Container()
                            : SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: LineChart(
                                  value.lineChartData!,
                                  duration: const Duration(milliseconds: 250),
                                ),
                              );
                      },
                    );
                  }
                  return Container();
                },
              )
            ],
          );
  }
}
