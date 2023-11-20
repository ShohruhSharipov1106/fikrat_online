import 'package:flutter/widgets.dart';
import 'package:fikrat_online/features/common/presentation/widgets/sliver_stack.dart';

class SliverAnimatedSwitcher extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration? reverseDuration;
  final Curve switchInCurve;
  final Curve switchOutCurve;

  const SliverAnimatedSwitcher({
    Key? key,
    required this.child,
    required this.duration,
    this.reverseDuration,
    this.switchInCurve = Curves.linear,
    this.switchOutCurve = Curves.linear,
  }) : super(key: key);

  static Widget defaultLayoutBuilder(Widget? currentChild, List<Widget> previousChildren) {
    return SliverStack(
      children: <Widget>[
        ...previousChildren,
        if (currentChild != null) currentChild,
      ],
    );
  }

  static Widget defaultTransitionBuilder(Widget child, Animation<double> animation) =>
      SliverFadeTransition(opacity: animation, sliver: child);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: reverseDuration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      layoutBuilder: defaultLayoutBuilder,
      transitionBuilder: defaultTransitionBuilder,
      child: child,
    );
  }
}
