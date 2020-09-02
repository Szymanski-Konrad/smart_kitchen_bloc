import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsLoad extends SettingsEvent {}

class NavigationChange extends SettingsEvent {
  final int index;

  NavigationChange({@required this.index});

  @override
  List<Object> get props => [];
}

