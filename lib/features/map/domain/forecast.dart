class Forecast {
  Forecast({
    required this.latitude,
    required this.longitude,
    required this.date,
    required this.measureLabel,
    required this.dailyValue,
  });

  final double latitude;
  final double longitude;
  final DateTime date;
  final String measureLabel;
  final dynamic dailyValue;

  factory Forecast.fromMap(Map<String, dynamic> data) {
    final latitude = data['latitude'] as double;
    final longitude = data['longitude'] as double;
    final date = DateTime.parse(data['date'].replaceAll('/', '-'));
    final measureLabel = data['measureLabel'] as String;
    dynamic dailyValue;
    try {
      dailyValue = data['dailyValue'] as double;
    } catch (exception) {
      dailyValue = data['dailyValue'] as String;
    }
    return Forecast(
        latitude: latitude,
        longitude: longitude,
        date: date,
        measureLabel: measureLabel,
        dailyValue: dailyValue);
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'date': date,
      'measureLabel': measureLabel,
      'dailyValue': dailyValue
    };
  }
}
