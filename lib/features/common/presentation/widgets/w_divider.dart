import 'package:flutter/material.dart';
import 'package:fikrat_online/assets/colors/colors.dart';

class WDivider extends StatelessWidget {
  final double? indent;
  const WDivider({this.indent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ghost,
      thickness: 1,
      height: 1,
      indent: indent,
    );
  }
}
