import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/theme_event.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/states/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
            ThemeState(textColor: Colors.white, backgroundColor: Colors.blue)) {
    on<ThemeEventChanged>(_onThemeEventChanged);
  }
  void _onThemeEventChanged(
      ThemeEventChanged event, Emitter<ThemeState> emit) async {
    ThemeState newThemeState;
    final weatherCondition = event.weatherCondition;
    if (weatherCondition == WeatherCondition.clear ||
        weatherCondition == WeatherCondition.lightCloud) {
      emit(newThemeState =
          ThemeState(textColor: Colors.black, backgroundColor: Colors.yellow));
    } else if (weatherCondition == WeatherCondition.hail ||
        weatherCondition == WeatherCondition.snow ||
        weatherCondition == WeatherCondition.sleet) {
      emit(newThemeState = ThemeState(
          textColor: Colors.white, backgroundColor: Colors.lightBlue));
    } else if (weatherCondition == WeatherCondition.heavyRain ||
        weatherCondition == WeatherCondition.lightRain ||
        weatherCondition == WeatherCondition.showers) {
      emit(newThemeState =
          ThemeState(textColor: Colors.white, backgroundColor: Colors.indigo));
    } else if (weatherCondition == WeatherCondition.thunderStorm) {
      emit(newThemeState = ThemeState(
          textColor: Colors.white, backgroundColor: Colors.deepPurple));
    } else {
      newThemeState = ThemeState(
          textColor: Colors.white, backgroundColor: Colors.lightBlue);
    }
    emit(newThemeState);
  }
}
