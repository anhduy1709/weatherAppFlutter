import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';

abstract class ThemeEvent extends Equatable {}

class ThemeEventChanged extends ThemeEvent {
  final WeatherCondition weatherCondition;
  ThemeEventChanged({required this.weatherCondition})
      : assert(weatherCondition != null);
  @override
  // TODO: implement props
  List<Object?> get props => [weatherCondition];
}
