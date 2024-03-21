enum WeatherDataDaily {
  tempAirDailyAvg,
  tempAirDailyMax,
  tempAirDailyMin,
  precipDailySum,
  windDirectionDailyAvgDegrees,
  windSpeedDailyAvg,
  humidityRelDailyAvg,
  windDirectionDailyAvg,
  soilMoisture0to10cmDailyAvg,
  windGustDailyMax,
  referenceEvapotranspirationDailySum,
  tempSurfaceDailyAvg,
  soilTemperature0to10cmDailyAvg,
}

extension WeatherDataExtension on WeatherDataDaily {
  String get description {
    switch (this) {
      case WeatherDataDaily.tempAirDailyAvg:
        return 'Temperature Air Daily Average (C)';
      case WeatherDataDaily.tempAirDailyMax:
        return 'Temperature Air Daily Maximum (C)';
      case WeatherDataDaily.tempAirDailyMin:
        return 'Temperature Air Daily Minimum (C)';
      case WeatherDataDaily.precipDailySum:
        return 'Precipitation Daily Sum (mm)';
      case WeatherDataDaily.windDirectionDailyAvgDegrees:
        return 'Wind Direction Daily Average (Degrees)';
      case WeatherDataDaily.windSpeedDailyAvg:
        return 'Wind Speed Daily Average (m/s)';
      case WeatherDataDaily.humidityRelDailyAvg:
        return 'Relative Humidity Daily Average (Percent)';
      case WeatherDataDaily.windDirectionDailyAvg:
        return 'Wind Direction Daily Average';
      case WeatherDataDaily.soilMoisture0to10cmDailyAvg:
        return 'Soil Moisture 0 to 10 cm Daily Average (Volume Percent)';
      case WeatherDataDaily.windGustDailyMax:
        return 'Wind Gust Daily Maximum (m/s)';
      case WeatherDataDaily.referenceEvapotranspirationDailySum:
        return 'Reference Evapotranspiration Daily Sum (mm)';
      case WeatherDataDaily.tempSurfaceDailyAvg:
        return 'Surface Temperature Daily Average (C)';
      case WeatherDataDaily.soilTemperature0to10cmDailyAvg:
        return 'Soil Temperature 0 to 10 cm Daily Average (C)';
      default:
        return 'Unknown';
    }
  }
}
