import 'package:flutter/material.dart';
import 'package:fikrat_online/assets/colors/colors.dart';

class SmallContainer extends StatelessWidget {
  const SmallContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: 40,
      height: 6,
      decoration: BoxDecoration(
        color: phoneHintColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
