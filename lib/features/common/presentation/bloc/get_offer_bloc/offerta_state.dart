part of 'offerta_bloc.dart';

class OffertaState extends Equatable {
  final StaticPageDetailEntity content;
  final String searchedType;
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus staticPageStatus;

  const OffertaState({
    this.content = const StaticPageDetailEntity(),
    this.searchedType = '',
    this.status = FormzSubmissionStatus.initial,
    this.staticPageStatus = FormzSubmissionStatus.initial,
  });

  OffertaState copyWith({
    StaticPageDetailEntity? content,
    FormzSubmissionStatus? status,
    String? searchedType,
    FormzSubmissionStatus? staticPageStatus,
  }) =>
      OffertaState(
        content: content ?? this.content,
        status: status ?? this.status,
        searchedType: searchedType ?? this.searchedType,
        staticPageStatus: staticPageStatus ?? this.staticPageStatus,
      );

  @override
  List<Object?> get props => [
        content,
        status,
        searchedType,
        staticPageStatus,
      ];
}
