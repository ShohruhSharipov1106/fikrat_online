import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:imkon_care/core/data/singletons/service_locator.dart';
import 'package:imkon_care/core/exceptions/failures.dart';
import 'package:imkon_care/features/common/data/repositories/common_repository_impl.dart';
import 'package:imkon_care/features/common/data/repositories/donations_repository_impl.dart';
import 'package:imkon_care/features/common/domain/entities/donation_entity.dart';
import 'package:imkon_care/features/common/domain/usecase/add_to_favorite_usecase.dart';
import 'package:imkon_care/features/common/domain/usecase/create_donation_share_usecase.dart';
import 'package:imkon_care/features/common/domain/usecase/get_donations_usecase.dart';
import 'package:imkon_care/features/fonds/domain/usecases/create_complaint_usecase.dart';

part 'donations_event.dart';

part 'donations_state.dart';

class DonationsBloc extends Bloc<DonationsEvent, DonationsState> {
  CreateComplaintUseCase _createComplaintUseCase =
      CreateComplaintUseCase(repository: serviceLocator<CommonRepositoryImpl>());
  GetDonationsUseCase _getDonationsUseCase = GetDonationsUseCase(repository: serviceLocator<DonationsRepositoryImpl>());
  CreateDonationShareUsecase _donationShareUsecase =
      CreateDonationShareUsecase(repository: serviceLocator<DonationsRepositoryImpl>());
  AddToFavoriteUseCase _addToFavoriteUseCase = AddToFavoriteUseCase(repo: serviceLocator<CommonRepositoryImpl>());

  DonationsBloc() : super(const DonationsState()) {
    on<GetDonations>(_getDonations);
    on<GetMoreDonations>(_getMoreDonations);
    on<CreateDonationShare>(_createDonationShare);
    on<CreateComplaintDonation>(_createComplaintDonation);
    on<AddToFavourite>(_addToFavourite);
    on<ReCreateBloc>(_reCreateBloc);
    on<ChangeDonationInList>(_changeDonationInList);
  }

  _getDonations(GetDonations event, Emitter<DonationsState> emit) async {
    emit(state.copyWith(donationsStatus: FormzSubmissionStatus.inProgress));
    final result = await _getDonationsUseCase.call(event.donationsParams);
    if (result.isRight) {
      emit(state.copyWith(
        donationsStatus: FormzSubmissionStatus.success,
        donations: result.right.results,
        donationsFetchMore: result.right.next != null,
        donationsNext: result.right.next,
        donationsLike: result.right.results.map((e) => e.isFavorite).toList(),
      ));
    }
  }

  _getMoreDonations(GetMoreDonations event, Emitter<DonationsState> emit) async {
    final result = await _getDonationsUseCase.call(GetDonationsParams(next: state.donationsNext));
    if (result.isRight) {
      emit(state.copyWith(
        donations: [...state.donations, ...result.right.results],
        donationsFetchMore: result.right.next != null,
        donationsNext: result.right.next,
        donationsLike: [...state.donationsLike, ...result.right.results.map((e) => e.isFavorite).toList()],
      ));
    }
  }

  _createDonationShare(CreateDonationShare event, Emitter<DonationsState> emit) async {
    final result = await _donationShareUsecase.call(event.params);
    // if (result.isRight) {
    //   emit(state.copyWith(
    //   ));
    // }
  }

  _createComplaintDonation(CreateComplaintDonation event, Emitter<DonationsState> emit) async {
    final result = await _createComplaintUseCase.call(
      CreateComplainParams(
        type: event.type,
        contentType: event.contentType,
        description: event.description,
        objectId: event.objectId,
        token: event.token,
      ),
    );
    if (result.isRight) {
      event.onSuccess();
    } else {
      if (result.left is ServerFailure) {
        event.onError((result.left as ServerFailure).errorMessage);
      } else if (result.left is ParsingFailure) {
        event.onError((result.left as ParsingFailure).errorMessage);
      } else {
        event.onError("Unknown Error");
      }
    }
  }

  _addToFavourite(AddToFavourite event, Emitter<DonationsState> emit) async {
    final result = await _addToFavoriteUseCase.call(event.id);
    if (result.isRight) {
      final int index = state.donations.indexWhere((element) => element.id == event.id);
      final List<DonationEntity> customList = [...state.donations];
      final DonationEntity donation = customList[index];
      customList.removeAt(index);

      customList.insert(
        index,
        DonationEntity(
          id: donation.id,
          company: donation.company,
          title: donation.title,
          isActive: donation.isActive,
          category: donation.category,
          region: donation.region,
          about: donation.about,
          commentCount: donation.commentCount,
          createdAt: donation.createdAt,
          donationCount: donation.donationCount,
          endTime: donation.endTime,
          gainedMoney: donation.gainedMoney,
          gainedMoneyInPercent: donation.gainedMoneyInPercent,
          isFavorite: !donation.isFavorite,
          isProjectReportReady: donation.isProjectReportReady,
          image: donation.image,
          shareCount: donation.shareCount,
          targetMoney: donation.targetMoney,
          userDonationAmount: donation.userDonationAmount,
          viewsCount: donation.viewsCount,
        ),
      );
      emit(state.copyWith(
        donations: customList,
        donationsLike: customList.map((e) => e.isFavorite).toList(),
      ));
    }
  }

  _reCreateBloc(ReCreateBloc event, Emitter<DonationsState> emit) async {
    _createComplaintUseCase = CreateComplaintUseCase(repository: serviceLocator<CommonRepositoryImpl>());
    _getDonationsUseCase = GetDonationsUseCase(repository: serviceLocator<DonationsRepositoryImpl>());
    _donationShareUsecase = CreateDonationShareUsecase(repository: serviceLocator<DonationsRepositoryImpl>());
    _addToFavoriteUseCase = AddToFavoriteUseCase(repo: serviceLocator<CommonRepositoryImpl>());
  }

  _changeDonationInList(ChangeDonationInList event, Emitter<DonationsState> emit) async {
    final int index = state.donations.indexWhere((element) => element.id == event.donation.id);
    final List<DonationEntity> customList = [...state.donations];
    customList.removeAt(index);

    customList.insert(index, event.donation
        // DonationEntity(
        //   id: donation.id,
        //   company: donation.company,
        //   title: donation.title,
        //   isActive: donation.isActive,
        //   category: donation.category,
        //   district: donation.district,
        //   about: donation.about,
        //   commentCount: donation.commentCount,
        //   createdAt: donation.createdAt,
        //   donationCount: donation.donationCount,
        //   endTime: donation.endTime,
        //   gainedMoney: donation.gainedMoney,
        //   gainedMoneyInPercent: donation.gainedMoneyInPercent,
        //   isFavorite: !donation.isFavorite,
        //   isProjectReportReady: donation.isProjectReportReady,
        //   image: donation.image,
        //   shareCount: donation.shareCount,
        //   targetMoney: donation.targetMoney,
        //   userDonationAmount: donation.userDonationAmount,
        //   viewsCount: donation.viewsCount,
        // ),
        );
    emit(state.copyWith(donations: customList));
  }
}
