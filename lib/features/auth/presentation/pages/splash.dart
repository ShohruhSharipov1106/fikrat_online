import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) => AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Color(0xFF2D072F),
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF711256),
                Color(0x80550B5B),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Column(
              children: [
                const Spacer(),
                const SizedBox(height: 96),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.logoHeart,
                    ),
                    const SizedBox(width: 12),
                    SvgPicture.asset(
                      AppIcons.logoText,
                    ),
                  ],
                ),
                const Spacer(),
                Lottie.asset(
                  'assets/lottie/loading.json',
                  width: 96,
                  height: 96,
                ),
              ],
            ),
          ),
        ),
      );
}
