import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherStateInitial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateSuccess extends WeatherState {
  final Weather weather;
  WeatherStateSuccess({required this.weather});
  @override
  // TODO: implement props
  List<Object?> get props => [weather];
}

class WeatherStateFail extends WeatherState {}
