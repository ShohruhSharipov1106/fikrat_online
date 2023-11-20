part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class MoveToTopEvent extends HomeEvent {
  const MoveToTopEvent();

  @override
  List<Object?> get props => [];
}
