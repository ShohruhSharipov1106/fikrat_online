import 'dart:io';

import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fikrat_online/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class SocialWidget extends StatelessWidget {
  final VoidCallback onTapGoogle;
  final VoidCallback onTapApple;

  const SocialWidget(
      {required this.onTapGoogle, required this.onTapApple, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            // TODO UNCOMMENT
            "LocaleKeys.or_login_social.tr()",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w400,
                color: disabledButton.withOpacity(0.6)),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: WScaleAnimation(
                onTap: onTapGoogle,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: socialWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.google),
                      const SizedBox(width: 8),
                      Text(
                        'Google',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (Platform.isIOS) ...{
              Expanded(
                child: WScaleAnimation(
                  onTap: onTapApple,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: socialWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppIcons.apple),
                        const SizedBox(width: 8),
                        Text(
                          'Apple',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: white),
                        )
                      ],
                    ),
                  ),
                ),
              )
            },
          ],
        ),
      ],
    );
  }
}
