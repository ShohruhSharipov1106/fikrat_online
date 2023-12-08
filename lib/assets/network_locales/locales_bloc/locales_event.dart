part of 'locales_bloc.dart';

abstract class LocalesEvent extends Equatable {
  const LocalesEvent();
}

class GetLocalesEvent extends LocalesEvent {
  final VoidCallback onSuccess;
  final VoidCallback onError;

  const GetLocalesEvent({
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object?> get props => [];
}
