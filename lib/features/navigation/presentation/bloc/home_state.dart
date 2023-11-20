part of 'home_bloc.dart';

class HomeState extends Equatable {
  final ScrollController controller;
  const HomeState({required this.controller});

  HomeState copyWith({ScrollController? controller}) {
    return HomeState(controller: controller ?? this.controller);
  }

  @override
  List<Object> get props => [controller];
}
