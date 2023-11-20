part of 'deep_link_bloc.dart';

abstract class DeepLinkEvent {
  const DeepLinkEvent();
}

class DeepLinkChanged extends DeepLinkEvent {
  final String uri;

  DeepLinkChanged({required this.uri});
}
