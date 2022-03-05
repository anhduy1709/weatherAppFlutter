import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

const urlBase = 'https://www.metaweather.com';
final locationUrl = (city) => '${urlBase}/api/location/search/?query=${city}';
final weatherUrl = (locationId) => '${urlBase}/api/location/${locationId}';

class WeatherRepository {
  final http.Client? httpClient;
  WeatherRepository({@required this.httpClient}) : assert(httpClient != null);
  Future<int> getLocationFromCity(String city) async {
    final responce = await httpClient!.get(Uri.parse(locationUrl(city)));
    if (responce.statusCode == 200) {
      final cities = jsonDecode(responce.body) as List;
      return (cities.first)['woeid'] ?? Map();
    } else {
      throw Exception('Error Getting LocationId from ${city}');
    }
  }

  Future<Weather> fetchWeather(int locationId) async {
    final responce = await httpClient!.get(Uri.parse(weatherUrl(locationId)));
    if (responce.statusCode == 200) {
      final weatherJson = jsonDecode(responce.body);
      return Weather.fromJson(weatherJson);
    }
    throw Exception('Error Getting Weather From ${locationId}');
  }

  Future<Weather> getWeatherFromCity(String city) async {
    final locationId = await getLocationFromCity(city);
    return fetchWeather(locationId);
  }
}
