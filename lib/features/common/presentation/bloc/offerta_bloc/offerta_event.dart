part of 'offerta_bloc.dart';

abstract class OffertaEvent extends Equatable {
  const OffertaEvent();
}

class GetOfferta extends OffertaEvent {
  final String type;
  const GetOfferta({required this.type});
  @override
  List<Object> get props => [];
}
