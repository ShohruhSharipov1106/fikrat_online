import 'package:flutter/material.dart';
import 'package:fikrat_online/assets/colors/colors.dart';

class WRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final double borderWidth;
  final Color backgroundColor;
  final double activeSize;
  final Color? centerColor;
  final Color? radioColor;

  const WRadio({
    required this.onChanged,
    required this.value,
    required this.groupValue,
    this.activeColor = mainColor,
    this.inactiveColor = titanWhite,
    this.borderWidth = 2,
    this.activeSize = 10,
    this.backgroundColor = Colors.transparent,
    this.centerColor,
    this.radioColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onChanged(value);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 80),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                border: Border.all(
                  color: value == groupValue ? activeColor : inactiveColor,
                  width: borderWidth,
                ),
                shape: BoxShape.circle,
                color: value == groupValue ? radioColor ?? mainColor : backgroundColor,
              ),
              padding: value == groupValue ? const EdgeInsets.all(3) : EdgeInsets.zero,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 80),
              height: activeSize,
              width: activeSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value == groupValue ? white : centerColor ?? Colors.transparent,
              ),
            ),
          ],
        ),
      );
}
