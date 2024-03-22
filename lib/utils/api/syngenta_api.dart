class SyngentaAPI {
  static const String _apiBaseUrl = 'services.cehub.syngenta-ais.com';
  static const String _apiPath = '/api/Forecast/';

  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    final parameters = parametersBuilder();
    final queryString = parameters.entries.map((entry) {
      final value = entry.value.toString().replaceAll(' ', '%20');
      return '${Uri.encodeComponent(entry.key)}=$value';
    }).join('&');

    return Uri.parse('https://$_apiBaseUrl$_apiPath$endpoint?$queryString');
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

  Uri nowcast(
      String format,
      String supplier,
      String startDate,
      String endDate,
      String measureLabel,
      double latitude,
      double longitude) =>
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
