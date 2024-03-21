class SyngentaAPI {
  static const String _apiBaseUrl = 'services.cehub.syngenta-ais.com';
  static const String _apiPath = '/api/Forecast/';

  Uri _buildUri(
      {required String endpoint,
      required Map<String, dynamic> Function() parametersBuilder}) {
    return Uri(
      scheme: 'https',
      host: _apiBaseUrl,
      path: '$_apiPath$endpoint',
      queryParameters: parametersBuilder(),
    );
  }

  Uri shortRangeForecastDaily(
          String format,
          String supplier,
          String startDate,
          String endDate,
          String measureLabel,
          double latitude,
          double longitude) =>
      _buildUri(
        endpoint: 'ShortRangeForecastDaily',
        parametersBuilder: () => forecastParameters(format, supplier, startDate,
            endDate, measureLabel, latitude, longitude),
      );

  Uri shortRangeForecastHourly(
          String format,
          String supplier,
          String startDate,
          String endDate,
          String measureLabel,
          double latitude,
          double longitude) =>
      _buildUri(
        endpoint: 'ShortRangeForecastHourly',
        parametersBuilder: () => forecastParameters(format, supplier, startDate,
            endDate, measureLabel, latitude, longitude),
      );

  Uri nowcast(String format, String supplier, String startDate, String endDate,
          String measureLabel, double latitude, double longitude) =>
      _buildUri(
        endpoint: 'Nowcast',
        parametersBuilder: () => forecastParameters(format, supplier, startDate,
            endDate, measureLabel, latitude, longitude),
      );

  Map<String, dynamic> forecastParameters(
          String format,
          String supplier,
          String startDate,
          String endDate,
          String measureLabel,
          double latitude,
          double longitude) =>
      {
        'format': format,
        'supplier': supplier,
        'startDate': startDate,
        'endDate': endDate,
        'measureLabel': measureLabel,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      };
}
