import 'dart:async';

import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/core/utils/my_functions.dart';
import 'package:fikrat_online/features/auth/domain/entities/authentication_status.dart';
import 'package:fikrat_online/features/auth/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:fikrat_online/features/auth/presentation/bloc/login_sign_up_bloc/login_sign_up_bloc.dart';
import 'package:fikrat_online/features/auth/presentation/widgets/auth_header.dart';
import 'package:fikrat_online/features/auth/presentation/widgets/timer_with_text.dart';
import 'package:fikrat_online/features/common/presentation/bloc/show_pop_up/show_pop_up_bloc.dart';
import 'package:fikrat_online/features/common/presentation/widgets/custom_screen.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_button.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:fikrat_online/features/navigation/presentation/home.dart';
import 'package:fikrat_online/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ConfirmCodeScreen extends StatefulWidget {
  final LoginSignUpBloc loginSignUpBloc;
  final String phoneNumber;
  const ConfirmCodeScreen({
    Key? key,
    required this.loginSignUpBloc,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<ConfirmCodeScreen> createState() => _ConfirmCodeScreenState();
}

class _ConfirmCodeScreenState extends State<ConfirmCodeScreen> {
  late TextEditingController textEditingController;
  late Timer secondsTimer;
  int secondS = 122;
  bool hasError = false;
  @override
  void initState() {
    secondsTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondS == 0) {
        secondsTimer.cancel();
        context
            .read<ShowPopUpBloc>()
        // TODO UNCOMMENT
            .add(ShowPopUp(message: "LocaleKeys.add_verify_code.tr()"));
      } else {
        secondS--;
      }
    });
    textEditingController = TextEditingController();
    textEditingController.addListener(() {
      if (textEditingController.text.isNotEmpty &&
          textEditingController.text.length < 6 &&
          textEditingController.text.length > 3) {
        setState(() {
          hasError = false;
        });
      }
      if (textEditingController.text.length == 6) {
        widget.loginSignUpBloc.add(LoginConfirmEvent(
          onError: (value) {
            context.read<ShowPopUpBloc>().add(ShowPopUp(message: value.tr()));
            hasError = true;
          },
          onSuccess: () {
            hasError = false;
            context.read<AuthenticationBloc>().add(
                  AuthenticationStatusChanged(
                    status: AuthenticationStatus.authenticated,
                  ),
                );
            Navigator.push(
                context,
                MaterialWithModalsPageRoute(
                    builder: (_) => const HomeScreen()));
          },
          code: textEditingController.text,
        ));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    secondsTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.loginSignUpBloc,
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Color(0xFF2D072F),
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent),
        child: KeyboardDismisser(
          child: CustomScreen(
            child: Scaffold(
              backgroundColor: Colors.black,
              resizeToAvoidBottomInset: false,
              body: BlocBuilder<LoginSignUpBloc, LoginSignUpState>(
                builder: (context, state) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFF711256),
                            Color(0x80550B5B),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).padding.top + 20),
                        // TODO UNCOMMENT
                        // SvgPicture.asset(
                        //   MyFunctions.getChangeAppIcons(
                        //       locale: context.locale.languageCode),
                        //   color: white,
                        // ),
                        AuthHeader(
                          title: LocaleKeys.confirm.tr(),
                          // TODO UNCOMMENT
                          subTitle: "LocaleKeys.code_send_the_phone.tr()",
                        ),
                        WScaleAnimation(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: mainColor.withOpacity(0.1)),
                              color: phoneFillColor.withOpacity(0.06),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // TODO UNCOMMENT
                                // Text(
                                //   MyFunctions.formatPhone(state.phone),
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .titleMedium!
                                //       .copyWith(color: white),
                                // ),
                                const SizedBox(width: 8),
                                SvgPicture.asset(AppIcons.editPen),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 46),
                        // TODO UNCOMMENT
                        // PinField(
                        //   title: LocaleKeys.verify_code.tr(),
                        //   isError: hasError,
                        //   autoFocus: true,
                        //   cursorColor: white,
                        //   onChanged: (value) {
                        //     if (secondsTimer.isActive) {}
                        //   },
                        //   controller: textEditingController,
                        // ),
                        TimerWithText(
                          postAction: (onSuccess) {
                            widget.loginSignUpBloc.add(SubmitPhone(
                                phone: widget.phoneNumber,
                                onError: (value) {},
                                onSuccess: () {}));
                            setState(() {
                              secondS = 122;
                              secondsTimer = Timer.periodic(
                                  const Duration(seconds: 1), (timer) {
                                if (secondS == 0) {
                                  secondsTimer.cancel();
                                  context
                                      .read<ShowPopUpBloc>()
                                      .add(ShowPopUp(message: 'Vaqt tugadi'));
                                } else {
                                  secondS--;
                                }
                              });
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        WButton(
                          margin: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).padding.bottom + 16),
                          onTap: () {
                            widget.loginSignUpBloc.add(LoginConfirmEvent(
                              onError: (value) {
                                context
                                    .read<ShowPopUpBloc>()
                                    .add(ShowPopUp(message: value.tr()));
                                hasError = true;
                              },
                              onSuccess: () async {
                                hasError = false;
                                context.read<AuthenticationBloc>().add(
                                      AuthenticationStatusChanged(
                                        status:
                                            AuthenticationStatus.authenticated,
                                      ),
                                    );
                                Navigator.push(
                                    context,
                                    MaterialWithModalsPageRoute(
                                        builder: (_) => const HomeScreen()));
                              },
                              code: textEditingController.text,
                            ));
                          },
                          text: LocaleKeys.continued.tr(),
                          textStyle: textEditingController.text.length < 6 ||
                                  !secondsTimer.isActive
                              ? Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: white.withOpacity(0.4))
                              : Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: tiber),
                          // TODO UNCOMMENT
                          // disabledColor: white.withOpacity(0.1),
                          color: white,
                          isDisabled: textEditingController.text.length < 6 ||
                              !secondsTimer.isActive,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
