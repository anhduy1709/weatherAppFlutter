import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/setting_bloc.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/states/theme_state.dart';

void main() {
  final WeatherRepository weatherRepository =
      WeatherRepository(httpClient: http.Client());
  runApp(BlocProvider<ThemeBloc>(
    create: (context) => ThemeBloc(),
    child: BlocProvider<SettingBloc>(
      create: (context) => SettingBloc(),
      child: MyApp(
        weatherRepository: weatherRepository,
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;
  const MyApp({Key? key, required this.weatherRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) =>
              WeatherBloc(weatherRepository: weatherRepository),
          child: Weather_Screen(),
        ),
      );
    });
  }
}
