import 'dart:async';

import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fikrat_online/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class RefreshButton extends StatefulWidget {
  final bool isDarkRefresh;
  final Function(VoidCallback onSuccess) onTap;

  const RefreshButton({
    Key? key,
    required this.onTap,
    required this.isDarkRefresh,
  }) : super(key: key);

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      upperBound: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WScaleAnimation(
        onTap: () {
          Timer(const Duration(milliseconds: 1000), () {
            _controller.stop();
          });
          widget.onTap(() {});
        },
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: widget.isDarkRefresh
                      ? mainColorWithOpacity1
                      : disabledButton),
              color: widget.isDarkRefresh
                  ? phoneFillColorWithOpacity06
                  : scaffoldBackground,
            ),
            child: Row(
              children: [
                Text(
                  LocaleKeys.resend.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: widget.isDarkRefresh ? white : baliHai),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(AppIcons.refresh,
                    color: widget.isDarkRefresh ? white : baliHai),
              ],
            ),
          ),
        ),
      );
}
