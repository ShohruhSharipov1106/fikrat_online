import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/core/data/singletons/service_locator.dart';
import 'package:fikrat_online/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:fikrat_online/features/auth/domain/usecases/login_usecase.dart';
import 'package:fikrat_online/features/auth/domain/usecases/submit_phone.dart';
import 'package:fikrat_online/features/auth/presentation/bloc/login_sign_up_bloc/login_sign_up_bloc.dart';
import 'package:fikrat_online/features/auth/presentation/bloc/social_login_bloc/social_login_bloc.dart';
import 'package:fikrat_online/features/auth/presentation/pages/confirm_code.dart';
import 'package:fikrat_online/features/auth/presentation/widgets/auth_header.dart';
import 'package:fikrat_online/features/auth/presentation/widgets/social_widget.dart';
import 'package:fikrat_online/features/common/presentation/bloc/show_pop_up/show_pop_up_bloc.dart';
import 'package:fikrat_online/features/common/presentation/widgets/custom_screen.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_button.dart';
import 'package:fikrat_online/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController loginController;
  late FocusNode focusNode;
  late LoginSignUpBloc loginSignUpBloc;
  bool hasError = false;

  @override
  void initState() {
    loginSignUpBloc = LoginSignUpBloc(
      submitPhoneUseCase: SubmitPhoneUseCase(
        repository: serviceLocator<AuthenticationRepositoryImpl>(),
      ),
      loginUseCase: LoginUseCase(
        repository: serviceLocator<AuthenticationRepositoryImpl>(),
      ),
    );
    loginController = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      loginSignUpBloc.add(FocusTextField(isFocus: focusNode.hasFocus));
    });

    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF711256),
    ));
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF711256),
    ));
    return BlocProvider(
      create: (context) => SocialLoginBloc(),
      child: BlocProvider.value(
        value: loginSignUpBloc,
        child: BlocBuilder<LoginSignUpBloc, LoginSignUpState>(
          builder: (context, state) {
            if (state.isFocus == false) {
              focusNode.unfocus();
            }
            return AnnotatedRegion(
              value: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                systemNavigationBarColor: Color(0xFF2D072F),
                systemNavigationBarIconBrightness: Brightness.light,
              ),
              child: CustomScreen(
                child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light,
                      systemNavigationBarColor: Color(0xFF2D072F),
                      systemNavigationBarIconBrightness: Brightness.light,
                      statusBarColor: Colors.transparent,
                    ),
                    elevation: 0,
                    leading: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SvgPicture.asset(
                          AppIcons.chevronLeft,
                          color: white,
                        ),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  backgroundColor: Colors.black,
                  body: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFF711256),
                            Color(0x80550B5B),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(flex: 1),
                        // TODO UNCOMMENT
                        AuthHeader(
                          title: "LocaleKeys.login.tr()",
                          subTitle: "LocaleKeys.login_phone.tr()",
                        ),
                        const SizedBox(height: 44),
                        // TODO UNCOMMENT
                        // PhoneTextField(
                        //   focusNode: focusNode,
                        //   onChanged: (value) {
                        //     if (value.length == 12 || value.length == 11) {
                        //       setState(() {
                        //         hasError = false;
                        //       });
                        //     }
                        //   },
                        //   title: "LocaleKeys.phone_number.tr()",
                        //   controller: loginController,
                        //   hasError: hasError,
                        // ),
                        if (state.isFocus == false &&
                            loginController.text.isEmpty) ...{
                          SocialWidget(
                            onTapGoogle: () {
                              context
                                  .read<SocialLoginBloc>()
                                  .add(LoginWithGoogle(onError: (message) {
                                context
                                    .read<ShowPopUpBloc>()
                                    .add(ShowPopUp(message: message));
                              }));
                            },
                            onTapApple: () {
                              context
                                  .read<SocialLoginBloc>()
                                  .add(LoginWithApple(onError: (message) {
                                context
                                    .read<ShowPopUpBloc>()
                                    .add(ShowPopUp(message: message));
                              }));
                            },
                          )
                        } else ...{
                          const SizedBox(height: 30)
                        },
                        // TODO UNCOMMENT
                        // const Spacer(flex: 3),
                        // if (loginController.text.length == 12) ...{
                        //   GestureDetector(
                        //     onTap: () {
                        //       showModalBottomSheet(
                        //         isScrollControlled: true,
                        //         isDismissible: false,
                        //         backgroundColor: Colors.transparent,
                        //         context: context,
                        //         builder: (context) {
                        //           return SizedBox(
                        //               height:
                        //                   MediaQuery.of(context).size.height *
                        //                       .85,
                        //               child: const OffertaottomSheet());
                        //         },
                        //       );
                        //     },
                        //     child: SizedBox(
                        //       height: 40,
                        //       child: RichText(
                        //         textAlign: TextAlign.center,
                        //         text: TextSpan(
                        //           text: '${LocaleKeys.to_continue_you.tr()} ',
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .titleSmall!
                        //               .copyWith(
                        //                   fontSize: 14,
                        //                   fontWeight: FontWeight.w400),
                        //           children: [
                        //             if (context.locale.languageCode == 'uz' ||
                        //                 context.locale.languageCode == 'uk' ||
                        //                 context.locale.languageCode ==
                        //                     'ka') ...{
                        //               WidgetSpan(
                        //                 child: Text(
                        //                   LocaleKeys.pub_oferta.tr(),
                        //                   style: Theme.of(context)
                        //                       .textTheme
                        //                       .labelLarge!
                        //                       .copyWith(
                        //                           fontWeight: FontWeight.w400,
                        //                           fontSize: 14),
                        //                 ),
                        //               ),
                        //               TextSpan(
                        //                 text:
                        //                     ' ${LocaleKeys.you_agree_to.tr()}',
                        //               ),
                        //             } else if (context.locale.languageCode ==
                        //                     'ru' ||
                        //                 context.locale.languageCode ==
                        //                     'en') ...{
                        //               TextSpan(
                        //                 text:
                        //                     ' ${LocaleKeys.you_agree_to.tr()}',
                        //               ),
                        //               WidgetSpan(
                        //                 child: Text(
                        //                   LocaleKeys.pub_oferta.tr(),
                        //                   style: Theme.of(context)
                        //                       .textTheme
                        //                       .labelLarge!
                        //                       .copyWith(
                        //                           fontWeight: FontWeight.w400,
                        //                           fontSize: 14),
                        //                 ),
                        //               ),
                        //             }
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   )
                        // },
                        // if (state.isFocus == true ||
                        //     loginController.text.isNotEmpty) ...{
                        //   WButton(
                        //     isDisabled: !(loginController.text.length == 12),
                        //     margin: EdgeInsets.only(
                        //       top: 12,
                        //       bottom:
                        //           MediaQuery.of(context).padding.bottom + 16,
                        //     ),
                        //     color: white,
                        //     disabledColor: white.withOpacity(0.1),
                        //     onTap: () {
                        //       loginSignUpBloc.add(SubmitPhone(
                        //           phone: loginController.text,
                        //           onError: (value) {
                        //             context.read<ShowPopUpBloc>().add(ShowPopUp(
                        //                 message: value.tr(),
                        //                 isNotification: true));
                        //             setState(() {
                        //               hasError = true;
                        //             });
                        //           },
                        //           onSuccess: () {
                        //             Navigator.push(
                        //                 context,
                        //                 fade(
                        //                     page: ConfirmCodeScreen(
                        //                   phoneNumber: loginController.text,
                        //                   loginSignUpBloc: loginSignUpBloc,
                        //                 )));
                        //           }));
                        //     },
                        //     textStyle: Theme.of(context)
                        //         .textTheme
                        //         .headlineSmall!
                        //         .copyWith(
                        //             color: loginController.text.length == 12
                        //                 ? tiber
                        //                 : white.withOpacity(0.4)),
                        //     text: LocaleKeys.continued.tr(),
                        //   )
                        // }
                        //
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
