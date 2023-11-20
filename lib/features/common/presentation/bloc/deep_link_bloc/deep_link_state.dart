part of 'deep_link_bloc.dart';

abstract class DeepLinkState extends Equatable {
  const DeepLinkState();
}

class DeepLinkInitial extends DeepLinkState {
  @override
  List<Object> get props => [];
}

class DeepLinkTriggeredState extends DeepLinkState {
  final String link;
  final String type;

  const DeepLinkTriggeredState({required this.link, required this.type});

  @override
  List<Object> get props => [];
}
