part of 'show_pop_up_bloc.dart';

class ShowPopUpState extends Equatable {
  final String message;
  final bool showPopUp;
  final bool isSuccess;
  const ShowPopUpState({
    required this.message,
    required this.showPopUp,
    required this.isSuccess,
  });

  ShowPopUpState copyWith({
    String? message,
    bool? showPopUp,
    bool? isSuccess,
  }) =>
      ShowPopUpState(
        message: message ?? this.message,
        showPopUp: showPopUp ?? this.showPopUp,
        isSuccess: isSuccess ?? this.isSuccess,
      );
  @override
  List<Object?> get props => [showPopUp, message, isSuccess];
}
