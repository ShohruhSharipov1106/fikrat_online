import 'package:flutter/material.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_check_box.dart';

class WCheckBoxTile extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onTap;
  final Color? checkBoxColor;
  final String title;
  final TextStyle? textStyle;
  final double checkBoxSize;
  final EdgeInsets? padding;
  final List<Widget>? actions;
  const WCheckBoxTile(
      {required this.title,
      required this.onTap,
      required this.isChecked,
      this.checkBoxColor,
      this.textStyle,
      this.padding,
      this.checkBoxSize = 22,
      this.actions,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WCheckBox(
              isChecked: isChecked,
              checkBoxColor: checkBoxColor ?? mainColor,
              size: checkBoxSize,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: textStyle ?? Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (actions != null) ...actions!
          ],
        ),
      ),
    );
  }
}
