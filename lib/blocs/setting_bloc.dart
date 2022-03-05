import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/setting_event.dart';
import 'package:weather_app/states/setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc()
      : super(SettingState(temperatureUnit: TemperatureUnit.celsius)) {
    on<SettingEventToggleUnit>(_onSettingEventToggleUnit);
  }
  void _onSettingEventToggleUnit(
      SettingEventToggleUnit event, Emitter<SettingState> emit) {
    emit(SettingState(
        temperatureUnit: state.temperatureUnit == TemperatureUnit.celsius
            ? TemperatureUnit.fahrenheit
            : TemperatureUnit.celsius));
  }
}
