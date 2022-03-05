import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/setting_bloc.dart';
import 'package:weather_app/events/setting_event.dart';
import 'package:weather_app/states/setting_state.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting Screen'),
      ),
      body: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, settingState) {
          return ListView(
            children: [
              ListTile(
                title: Text('Temperature Unit'),
                isThreeLine: true,
                subtitle: Text(
                    settingState.temperatureUnit == TemperatureUnit.celsius
                        ? 'Celsius'
                        : 'Fahrenheit'),
                trailing: Switch(
                    value:
                        settingState.temperatureUnit == TemperatureUnit.celsius,
                    onChanged: (_) => BlocProvider.of<SettingBloc>(context)
                        .add(SettingEventToggleUnit())),
              )
            ],
          );
        },
      ),
    );
  }
}
