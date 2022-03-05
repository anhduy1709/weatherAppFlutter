import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/setting_bloc.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/states/setting_state.dart';
import 'package:weather_app/states/theme_state.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather weather;
  const TemperatureWidget({Key? key, required this.weather}) : super(key: key);
  int _toFahrenheit(double celcius) => ((celcius * 9 / 5) + 32).round();
  String _formattedTemperature(double temp, TemperatureUnit temperatureUnit) =>
      temperatureUnit == TemperatureUnit.fahrenheit
          ? '${_toFahrenheit(temp)} °F'
          : '${temp.round()} °C';
  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: BlocBuilder<SettingBloc, SettingState>(
                builder: (context, settingState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Min Temp: ${_formattedTemperature(weather.minTemp!, settingState.temperatureUnit)}',
                    style:
                        TextStyle(fontSize: 18, color: _themeState.textColor),
                  ),
                  Text(
                    'Temp: ${_formattedTemperature(weather.temp!, settingState.temperatureUnit)}',
                    style:
                        TextStyle(fontSize: 18, color: _themeState.textColor),
                  ),
                  Text(
                    'Max Temp: ${_formattedTemperature(weather.maxTemp!, settingState.temperatureUnit)}',
                    style:
                        TextStyle(fontSize: 18, color: _themeState.textColor),
                  )
                ],
              );
            }))
      ],
    );
  }
}
