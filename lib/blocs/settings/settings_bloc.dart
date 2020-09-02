import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:smart_kitchen/blocs/settings/settings.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  
  @override
  SettingsState get initialState => SettingsState.empty();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is NavigationChange) {
      yield* _mapNavigationChangeToState(event.index);
    }
  }

  Stream<SettingsState> _mapNavigationChangeToState(int index) async* {
    yield state.update(currentIndex: index);
  }
}