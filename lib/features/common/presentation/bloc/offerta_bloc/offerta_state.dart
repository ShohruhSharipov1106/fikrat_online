part of 'offerta_bloc.dart';

class OffertaState extends Equatable {
  final String searchedType;
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus staticPageStatus;

  const OffertaState({
    this.searchedType = '',
    this.status = FormzSubmissionStatus.initial,
    this.staticPageStatus = FormzSubmissionStatus.initial,
  });

  OffertaState copyWith({
    FormzSubmissionStatus? status,
    String? searchedType,
    FormzSubmissionStatus? staticPageStatus,
  }) =>
      OffertaState(
        status: status ?? this.status,
        searchedType: searchedType ?? this.searchedType,
        staticPageStatus: staticPageStatus ?? this.staticPageStatus,
      );

  @override
  List<Object?> get props => [
        status,
        searchedType,
        staticPageStatus,
      ];
}
