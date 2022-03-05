import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final Color textColor;
  final Color backgroundColor;

  ThemeState({required this.textColor, required this.backgroundColor});
  @override
  // TODO: implement props
  List<Object?> get props => [textColor,backgroundColor];
}
