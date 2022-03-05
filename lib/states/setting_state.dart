import 'package:equatable/equatable.dart';


enum TemperatureUnit {
  celsius,
  fahrenheit,
}

class SettingState extends Equatable {
  final TemperatureUnit temperatureUnit;
  SettingState({required this.temperatureUnit});
  @override
  // TODO: implement props
  List<Object?> get props => [temperatureUnit];
}
