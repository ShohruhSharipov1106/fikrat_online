import 'dart:async';
import 'dart:io';

import 'package:fikrat_online/assets/themes/theme.dart';
import 'package:fikrat_online/core/data/singletons/service_locator.dart';
import 'package:fikrat_online/core/data/singletons/storage.dart';
import 'package:fikrat_online/features/auth/domain/entities/authentication_status.dart';
import 'package:fikrat_online/features/auth/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:fikrat_online/features/auth/presentation/pages/onboarding_screen.dart';
import 'package:fikrat_online/features/auth/presentation/pages/splash.dart';
import 'package:fikrat_online/features/common/domain/repositories/connectivity_repository.dart';
import 'package:fikrat_online/features/common/presentation/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:fikrat_online/features/common/presentation/bloc/deep_link_bloc/deep_link_bloc.dart';
import 'package:fikrat_online/features/common/presentation/bloc/show_pop_up/show_pop_up_bloc.dart';
import 'package:fikrat_online/features/navigation/presentation/home.dart';
import 'package:fikrat_online/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await DefaultCacheManager().emptyCache();
  await setupLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runZonedGuarded(() {
    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('uz'),
          Locale('uk'),
          Locale('ru'),
          Locale('en'),
          Locale('ka'),
        ],
        path: 'lib/assets/translations',
        fallbackLocale: const Locale('uz'),
        startLocale: const Locale('uz'),
        child: const App(),
      ),
    );
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
  HttpOverrides.global = MyHttpOverrides();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get navigator => _navigatorKey.currentState!;
  late ConnectivityRepository connectivityRepository;
  late ConnectivityBloc connectivityBloc;

  @override
  void initState() {
    connectivityRepository = ConnectivityRepository();
    connectivityBloc = ConnectivityBloc(connectivityRepository)
      ..add(const SetupConnectivity());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider.value(value: connectivityRepository)],
      child: MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create: (context) => AuthenticationBloc(
          //     statusUseCase: GetAuthenticationStatusUseCase(
          //       repository: serviceLocator<AuthenticationRepositoryImpl>(),
          //     ),
          //     getUserDataUseCase: GetUserDataUseCase(
          //       repository: serviceLocator<ProfileRepositoryImpl>(),
          //     ),
          //   ),
          // ),
          BlocProvider.value(value: connectivityBloc),
          BlocProvider(create: (context) => ShowPopUpBloc()),
          BlocProvider(create: (context) => DeepLinkBloc()),
        ],
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              systemNavigationBarColor: Colors.white,
              statusBarBrightness: Brightness.light,
              systemNavigationBarIconBrightness: Brightness.dark),
          child: MaterialApp(
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Ayol Uchun',
            navigatorKey: _navigatorKey,
            theme: AppTheme.theme(),
            builder: (context, child) {
              return BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  switch (state.status) {
                    case AuthenticationStatus.unauthenticated:
                      if (StorageRepository.getBool(StoreKeys.onboarding)) {
                        navigator.pushAndRemoveUntil(
                            MaterialWithModalsPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false);
                      } else {
                        navigator.pushAndRemoveUntil(
                            CupertinoPageRoute(
                              builder: (context) => const OnboardingScreen(),
                            ),
                            (route) => false);
                      }
                      break;
                    case AuthenticationStatus.authenticated:
                      navigator.pushAndRemoveUntil(
                          MaterialWithModalsPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false);
                      break;
                  }
                },
                child: child,
              );
            },

            onGenerateRoute: (_) => MaterialPageRoute(
              builder: (_) => const SplashScreen(),
            ),
            // onGenerateRoute: (_) => MaterialPageRoute(
            //   builder: (_) => const ,
            // ),
            // home: const LoginScreen(),
            // SplashScreen.route(),
          ),
        ),
      ),
    );
  }
}
