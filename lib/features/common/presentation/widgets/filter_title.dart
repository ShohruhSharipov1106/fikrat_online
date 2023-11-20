import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_scale_animation.dart';

class FilterTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const FilterTitle({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        const Spacer(),
        WScaleAnimation(
          onTap: onTap ?? () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
            child: SvgPicture.asset(AppIcons.clear),
          ),
        )
      ],
    );
  }
}
