import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:start_hack/features/map/domain/forecast.dart';

import 'package:http/http.dart' as http;

import '../../../utils/api/exceptions.dart';
import '../../../utils/api/syngenta_api.dart';

class HttpSyngentaRepository extends ChangeNotifier {
  HttpSyngentaRepository({required this.api, required this.client});
  final SyngentaAPI api;
  final http.Client client;

  Future<List<Forecast>> getShortRangeForecastDaily(
          String format,
          String supplier,
          String startDate,
          String endDate,
          String measureLabel,
          double latitude,
          double longitude) =>
      _getData(
        uri: api.shortRangeForecastDaily(format, supplier, startDate, endDate,
            measureLabel, latitude, longitude),
        builder: (data) =>
            List.from(data.map((model) => Forecast.fromMap(model))),
      );

  Future<List<Forecast>> getShortRangeForecastHourly(
          String format,
          String supplier,
          String startDate,
          String endDate,
          String measureLabel,
          double latitude,
          double longitude) =>
      _getData(
        uri: api.shortRangeForecastHourly(format, supplier, startDate, endDate,
            measureLabel, latitude, longitude),
        builder: (data) =>
            List.from(data.map((model) => Forecast.fromMap(model))),
      );

  Future<List<Forecast>> getNowcast(
          String format,
          String supplier,
          String startDate,
          String endDate,
          String measureLabel,
          double latitude,
          double longitude) =>
      _getData(
        uri: api.nowcast(format, supplier, startDate, endDate, measureLabel,
            latitude, longitude),
        builder: (data) =>
            List.from(data.map((model) => Forecast.fromMap(model))),
      );

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.get(uri,
          headers: {'ApiKey': '9a8a4d5c-5d90-45da-919c-f1d3b2225dd6'});
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        default:
          throw UnknownException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }
}
