import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool showBackButton;

  const AuthHeader({
    this.title = '',
    this.subTitle = '',
    this.showBackButton = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showBackButton) ...{
            WScaleAnimation(
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 16),
                child: SvgPicture.asset(AppIcons.chevronDown),
              ),
            )
          },
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 24, color: white)),
          const SizedBox(height: 8),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w400,
                color: disabledButton.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
