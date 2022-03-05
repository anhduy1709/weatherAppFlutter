import 'package:equatable/equatable.dart';

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderStorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unKnown,
}

class Weather extends Equatable {
  final WeatherCondition? weatherCondition;
  final String? formattedCondition;
  final double? minTemp;
  final double? temp;
  final double? maxTemp;
  final int? locationId;
  final String? created;
  final DateTime? lastUpdated;
  final String? location;

  Weather(
      {this.weatherCondition,
      this.formattedCondition,
      this.minTemp,
      this.temp,
      this.maxTemp,
      this.locationId,
      this.location,
      this.created,
      this.lastUpdated});

  @override
  // TODO: implement props
  List<Object?> get props => [
        weatherCondition,
        formattedCondition,
        minTemp,
        temp,
        maxTemp,
        locationId,
        created,
        lastUpdated,
        location
      ];

  /* 
consolidated_weather: [
{
id: 4632659914391552,
weather_state_name: "Clear",
weather_state_abbr: "c",
wind_direction_compass: "NNE",
created: "2021-11-26T13:08:16.550977Z",
applicable_date: "2021-11-26",
min_temp: 9.015,
max_temp: 18,
the_temp: 16.61,
wind_speed: 4.026300807733503,
wind_direction: 31.453319186977783,
air_pressure: 1026,
humidity: 50,
visibility: 12.509134156525889,
predictability: 68
},
*/
  factory Weather.fromJson(dynamic jsonObject) {
    final consolidatedWeather = jsonObject['consolidated_weather'][0];
    return Weather(
        weatherCondition: _mapStringToWeatherCondition(
            consolidatedWeather['weather_state_abbr']),
        formattedCondition: consolidatedWeather['weather_state_name'] ?? '',
        minTemp: consolidatedWeather['min_temp'] as double,
        temp: consolidatedWeather['the_temp'] as double,
        maxTemp: consolidatedWeather['max_temp'] as double,
        locationId: jsonObject['woeid'] as int,
        created: consolidatedWeather['created'],
        location: jsonObject['title'],
        lastUpdated: DateTime.now());
  }
  static WeatherCondition _mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherCondition> map = {
      'sn': WeatherCondition.snow,
      'sl': WeatherCondition.sleet,
      'h': WeatherCondition.hail,
      't': WeatherCondition.thunderStorm,
      'hr': WeatherCondition.heavyRain,
      'lr': WeatherCondition.lightRain,
      's': WeatherCondition.showers,
      'hc': WeatherCondition.heavyCloud,
      'lc': WeatherCondition.lightCloud,
      'c': WeatherCondition.clear,
    };
    return map[inputString] ?? WeatherCondition.unKnown;
  }
}
