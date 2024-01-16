import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/features/auth/presentation/widgets/language_bottomsheet.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageItem extends StatelessWidget {
  final String icon;
  final String title;
  final String keys;
  final ValueChanged<LanguageModel> onTap;
  const LanguageItem({
    required this.onTap,
    required this.title,
    required this.icon,
    required this.keys,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: () => onTap(LanguageModel(
        title: title,
        flag: icon,
        keys: keys,
      )),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            if (keys == context.locale.languageCode) ...{
              SvgPicture.asset(AppIcons.lanTick),
            }
          ],
        ),
      ),
    );
  }
}
