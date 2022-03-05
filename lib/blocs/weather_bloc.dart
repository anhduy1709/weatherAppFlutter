import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/states/weather_state.dart';

// class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
//   final WeatherRepository weatherRepository;
//   WeatherBloc({required this.weatherRepository})
//       : super(WeatherStateInitial()) {
//     on<WeatherEventRequested>(_onWeatherRequested);
//     on<WeatherEventRefresh>(_onWeatherRefresh);
//   }
//   void _onWeatherRequested(
//       WeatherEventRequested event, Emitter<WeatherState> emit) async {
//     emit(WeatherStateLoading());
//     try {
//       final Weather weather =
//           await weatherRepository.getWeatherFromCity(event.city!);
//       emit(WeatherStateSuccess(weather: weather));
//     } catch (_) {
//       emit(WeatherStateFail());
//     }
//   }

//   void _onWeatherRefresh(
//       WeatherEventRefresh event, Emitter<WeatherState> emit) async {
//     emit(WeatherStateLoading());
//     try {
//       final Weather weather =
//           await weatherRepository.getWeatherFromCity(event.city!);
//       emit(WeatherStateSuccess(weather: weather));
//     } catch (_) {
//       emit(WeatherStateFail());
//     }
//   }
//   // final WeatherRepository weatherRepository;
//   // WeatherBloc({required this.weatherRepository})
//   //     : assert(weatherRepository != null),
//   //       super(WeatherStateInitial());
//   // @override
//   // Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async* {
//   //   if (weatherEvent is WeatherEventRequested) {
//   //     print('loading');
//   //     yield WeatherStateLoading();
//   //     try {
//   //       print('success');
//   //       final Weather weather =
//   //           await weatherRepository.getWeatherFromCity(weatherEvent.city!);
//   //       yield WeatherStateSuccess(weather: weather);
//   //     } catch (exception) {
//   //       print('fail');
//   //       yield WeatherStateFail();
//   //     }
//   //   } else if (weatherEvent is WeatherEventRefresh) {
//   //     try {
//   //       final Weather weather =
//   //           await weatherRepository.getWeatherFromCity(weatherEvent.city!);
//   //       yield WeatherStateSuccess(weather: weather);
//   //     } catch (exception) {
//   //       yield WeatherStateFail();
//   //     }
//   //   }
//   // }
// }

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository})
      : super(WeatherStateInitial()) {
    on<WeatherEventRequested>(_onWeatherEventRequested);
    on<WeatherEventRefresh>(_onWeatherEventRefresh);
  }
  void _onWeatherEventRequested(
      WeatherEventRequested event, Emitter<WeatherState> emit) async {
    emit(WeatherStateLoading());
    try {
      final Weather weather =
          await weatherRepository.getWeatherFromCity(event.city!);
      emit(WeatherStateSuccess(weather: weather));
    } catch (e) {
      emit(WeatherStateFail());
    }
  }

  void _onWeatherEventRefresh(
      WeatherEventRefresh event, Emitter<WeatherState> emit) async {
    emit(WeatherStateLoading());
    try {
      final Weather weather =
          await weatherRepository.getWeatherFromCity(event.city!);
      emit(WeatherStateSuccess(weather: weather));
    } catch (e) {
      emit(WeatherStateFail());
    }
  }
}
