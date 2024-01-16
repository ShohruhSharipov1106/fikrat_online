import 'dart:developer';
import 'dart:io';

import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/features/auth/domain/entities/social_network_type.dart';
import 'package:fikrat_online/features/auth/domain/usecases/social_login_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'social_login_event.dart';

part 'social_login_state.dart';

class SocialLoginBloc extends Bloc<SocialLoginEvent, SocialLoginState> {
  final SocialLoginUseCase _useCase = SocialLoginUseCase();

  SocialLoginBloc() : super(SocialLoginInitial()) {
    on<LoginWithApple>((event, emit) async {
      emit(SocialLoginLoading());
      final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: Platform.isAndroid
              ? WebAuthenticationOptions(
                  clientId: 'org.uicgroup.avto.uz.client',
                  redirectUri: Uri.parse('https://avto.uz/login'))
              : null);

      log(credential.toString());
      log(credential.authorizationCode);
      log(credential.identityToken.toString());
      log(credential.authorizationCode.toString());
      log(credential.userIdentifier.toString());
      log(credential.toString());
      final result = await _useCase.call(
        SocialLoginParams(
          type: SocialNetworkType.apple,
          code: credential.authorizationCode,
          accessToken: null,
        ),
      );
      if (result.isRight) {
        emit(SocialLoginSuccess());
      } else {
        if (result.left is ServerFailure) {
          event.onError((result.left as ServerFailure).errorMessage);
        }
        emit(SocialLoginFailure());
      }
    });
    on<LoginWithGoogle>((event, emit) async {
      emit(SocialLoginLoading());
      final googleResult = await GoogleSignIn(
        scopes: [
          'openid',
          'https://www.googleapis.com/auth/userinfo.profile',
          'https://www.googleapis.com/auth/userinfo.email',
        ],
      ).signIn();
      log('result: ${await googleResult?.authHeaders}');
      await googleResult?.authentication.then((value) async {
        final result = await _useCase.call(
          SocialLoginParams(
            type: SocialNetworkType.google,
            code: googleResult.serverAuthCode ?? '',
            accessToken: value.accessToken ?? '',
          ),
        );
        if (result.isRight) {
          emit(SocialLoginSuccess());
        } else {
          if (result.left is ServerFailure) {
            event.onError((result.left as ServerFailure).errorMessage);
          }
          emit(SocialLoginFailure());
        }
      });
    });
  }
}
