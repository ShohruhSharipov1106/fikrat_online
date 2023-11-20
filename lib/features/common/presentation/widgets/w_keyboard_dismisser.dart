import 'package:flutter/material.dart';

class WKeyboardDismisser extends StatefulWidget {
  final Widget child;

  const WKeyboardDismisser({required this.child, Key? key}) : super(key: key);

  @override
  State<WKeyboardDismisser> createState() => _WKeyboardDismisserState();
}

class _WKeyboardDismisserState extends State<WKeyboardDismisser>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onHorizontalDragEnd: (_) {
      //   WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      // },
      // onVerticalDragEnd: (_) {
      //   WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      // },
      // onHorizontalDragCancel: () {
      //   WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      // },
      // onVerticalDragCancel: () {
      //   WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      // },
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
