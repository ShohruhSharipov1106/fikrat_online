import 'package:flutter/material.dart';

class IndicatorDismisser extends StatelessWidget {
  final Widget child;
  const IndicatorDismisser({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: child,
    );
  }
}
