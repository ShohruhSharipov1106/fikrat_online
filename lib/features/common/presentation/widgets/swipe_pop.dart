import 'package:flutter/material.dart';

class SwipePop extends StatelessWidget {
  final Widget child;

  const SwipePop({required this.child, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.localPosition.dx < MediaQuery.of(context).size.width / 4) {
            Navigator.of(context).pop();
          }
        },
        child: child,
      );
}
