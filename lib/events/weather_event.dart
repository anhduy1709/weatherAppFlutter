import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherEventRequested extends WeatherEvent {
  final String? city;
  WeatherEventRequested({@required this.city}) : assert(city != null);
  @override
  // TODO: implement props
  List<Object?> get props => [city];
}

class WeatherEventRefresh extends WeatherEvent {
  final String? city;
  WeatherEventRefresh({@required this.city}) : assert(city != null);
  @override
  // TODO: implement props
  List<Object?> get props => [city];
}
