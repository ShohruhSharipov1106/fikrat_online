import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_scale_animation.dart';

class BottomSheetHeader extends StatelessWidget {
  final String title;
  final bool hasArrowLeft;
  final bool hasCloseIcon;
  final bool centerTitle;
  final VoidCallback? onBackTap;
  final TextStyle? titleStyle;
  final VoidCallback? onCloseTap;

  const BottomSheetHeader(
      {required this.title,
      this.hasArrowLeft = true,
      this.centerTitle = false,
      this.hasCloseIcon = true,
      this.titleStyle,
      this.onBackTap,
      this.onCloseTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasArrowLeft) ...{
          const SizedBox(width: 12),
          WScaleAnimation(
            onTap: onBackTap ??
                () {
                  Navigator.pop(context);
                },
            child: SvgPicture.asset(
              AppIcons.arrowLeft,
              width: 24,
              height: 24,
              color: black,
            ),
          ),
        },
        const SizedBox(width: 12),
        if (centerTitle) ...{
          Expanded(
            child: Center(
              child: Text(
                title,
                style: titleStyle ?? Theme.of(context).textTheme.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        } else ...{
          Expanded(
            child: Text(
              title,
              style: titleStyle ?? Theme.of(context).textTheme.bodyLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // const Spacer(),
        },
        if (hasCloseIcon) ...{
          WScaleAnimation(
            onTap: onCloseTap ??
                () {
                  Navigator.pop(context);
                },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 20, 16),
              child: SvgPicture.asset(
                AppIcons.clear,
                height: 12,
                width: 12,
              ),
            ),
          ),
        },
      ],
    );
  }
}
