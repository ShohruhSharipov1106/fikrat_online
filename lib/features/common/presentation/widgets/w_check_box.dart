import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';

class WCheckBox extends StatelessWidget {
  final bool isChecked;
  final Color checkBoxColor;
  final double size;
  final String? activeIcon;

  const WCheckBox({
    required this.isChecked,
    this.size = 24,
    this.checkBoxColor = mainColor,
    this.activeIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedContainer(
      key: key,
      duration: const Duration(milliseconds: 150),
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isChecked ? checkBoxColor : white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isChecked ? checkBoxColor : titanWhite,
          width: 1.6,
        ),
      ),
      child: isChecked ? SvgPicture.asset(activeIcon ?? AppIcons.activeCheckbox) : const SizedBox());
}
