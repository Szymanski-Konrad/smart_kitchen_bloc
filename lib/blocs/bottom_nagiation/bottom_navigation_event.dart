import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class BottomStarted extends BottomNavigationEvent {
  @override
  String toString() => 'AppStarted BottomNavigation';
}

class PageTapped extends BottomNavigationEvent {
  final int index;

  PageTapped({@required this.index});

  @override
  String toString() => 'PageTapped: $index';
}
