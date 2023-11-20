import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:imkon_care/core/data/singletons/service_locator.dart';
import 'package:imkon_care/features/common/data/repositories/donations_repository_impl.dart';
import 'package:imkon_care/features/common/domain/usecase/get_advertisement_usecase.dart';
import 'package:imkon_care/features/common/domain/usecase/get_donations_usecase.dart';
import 'package:imkon_care/features/home/domain/entities/advertisement_entity.dart';

part 'advertisement_event.dart';
part 'advertisement_state.dart';

class AdvertisementBloc extends Bloc<AdvertisementEvent, AdvertisementState> {
  final GetAdvertisementUseCase _getAdvertisementUseCase =
      GetAdvertisementUseCase(repository: serviceLocator<DonationsRepositoryImpl>());
  AdvertisementBloc() : super(const AdvertisementState()) {
    on<GetAdvertisements>(_getAdvertisements);
    on<GetMoreAdvertisements>(_getMoreAdvertisements);
  }

  _getAdvertisements(GetAdvertisements event, Emitter<AdvertisementState> emit) async {
    emit(state.copyWith(advertisementsStatus: FormzSubmissionStatus.inProgress));
    final result = await _getAdvertisementUseCase.call(event.advertisementsParams);
    if (result.isRight) {
      emit(state.copyWith(
        advertisementsStatus: FormzSubmissionStatus.success,
        advertisements: result.right,
      ));
    }
  }

  _getMoreAdvertisements(GetMoreAdvertisements event, Emitter<AdvertisementState> emit) async {
    final result = await _getAdvertisementUseCase.call(GetDonationsParams(next: state.advertisementsNext));
    if (result.isRight) {
      emit(state.copyWith(
        advertisements: [...state.advertisements, ...result.right],
      ));
    }
  }
}
