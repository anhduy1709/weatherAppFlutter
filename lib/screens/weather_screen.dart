import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/events/theme_event.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/screens/city_search_screen.dart';
import 'package:weather_app/screens/setting_screen.dart';
import 'package:weather_app/screens/temperature_screen.dart';
import 'package:weather_app/states/theme_state.dart';
import 'package:weather_app/states/weather_state.dart';

class Weather_Screen extends StatefulWidget {
  const Weather_Screen({Key? key}) : super(key: key);

  @override
  _Weather_ScreenState createState() => _Weather_ScreenState();
}

class _Weather_ScreenState extends State<Weather_Screen> {
  Completer<void>? _completer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App Of Mine'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingScreen(),
                    ));
              },
              icon: Icon(Icons.settings)),
          IconButton(
              onPressed: () async {
                final city = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CitySearchScreen()));
                if (city != null) {
                  BlocProvider.of<WeatherBloc>(context)
                      .add(WeatherEventRequested(city: city));
                }
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, weatherState) {
            if (weatherState is WeatherStateSuccess) {
              return BlocProvider.of<ThemeBloc>(context).add(ThemeEventChanged(
                  weatherCondition: weatherState.weather.weatherCondition!));
            }
            _completer?.complete();
            _completer = Completer();
          },
          builder: (context, weatherState) {
            if (weatherState is WeatherStateLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (weatherState is WeatherStateSuccess) {
              final Weather weather = weatherState.weather;
              return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                return RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(WeatherEventRefresh(city: weather.location));
                    return _completer!.future;
                  },
                  child: Container(
                    color: themeState.backgroundColor,
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Text(
                              weather.location!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                            ),
                            Center(
                              child: Text(
                                'Updated: ${TimeOfDay.fromDateTime(weather.lastUpdated!).format(context)}',
                                style: TextStyle(
                                    fontSize: 16, color: themeState.textColor),
                              ),
                            ),
                            TemperatureWidget(weather: weather)
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
            }
            if (weatherState is WeatherStateFail) {
              return Center(
                child: Text(
                  'Something Went Wrong',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            return Center(child: Text('Select a location first'));
          },
        ),
      ),
    );
  }
}
