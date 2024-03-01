import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final double? iconSize;
  final Color? iconColor;
  final double separator;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Widget? bottom;

  const NoDataWidget({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconColor,
    this.iconSize,
    this.separator = 20,
    this.titleStyle,
    this.subtitleStyle,
    this.bottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        // color: white,
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                width: iconSize,
                height: iconSize,
                color: iconColor,
              ),
              SizedBox(height: separator),
              Text(
                title,
                style: titleStyle ?? Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                style: subtitleStyle ?? Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              if (bottom != null) ...{bottom!},
            ],
          ),
        ),
      );
}
