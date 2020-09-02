import 'package:meta/meta.dart';

class SettingsState {
  final int currentIndex;

  SettingsState({this.currentIndex});

  factory SettingsState.empty() {
    return SettingsState(
      currentIndex: 0,
    );
  }

  SettingsState update({
    int currentIndex,
  }) {
    return copyWith(
      currentIndex: currentIndex,
    );
  }

  SettingsState copyWith({
    int currentIndex,
  }) {
    return SettingsState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}