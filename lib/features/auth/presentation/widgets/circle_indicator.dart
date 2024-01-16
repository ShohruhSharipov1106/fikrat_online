import 'package:flutter/material.dart';

class CircleIndicator extends StatefulWidget {
  const CircleIndicator({Key? key}) : super(key: key);

  @override
  State<CircleIndicator> createState() => _CircleIndicatorState();
}

class _CircleIndicatorState extends State<CircleIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    controller.repeat();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CircleIndicator oldWidget) {
    controller.repeat();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, index) => CustomPaint(
        painter: _CirclePaint(position: animation),
      ),
    );
  }
}

const List<double> _kCircleOpacityList = [0.25, 0.5, 0.75, 1];

class _CirclePaint extends CustomPainter {
  final Animation<double> position;

  const _CirclePaint({required this.position}) : super(repaint: position);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final int tickCount = _kCircleOpacityList.length;
    canvas.save();
    canvas.translate(size.width, size.height);
    final int activeTick = (tickCount * position.value).floor();
    for (int i = 0; i < tickCount; ++i) {
      final int t = (i - activeTick) % tickCount;
      paint.color = const Color(0xff181919).withOpacity(_kCircleOpacityList[t]);
      canvas.drawCircle(
          Offset((20 * i).toDouble(), -position.value * t * 2), 2.0 * t, paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CirclePaint oldDelegate) {
    return oldDelegate.position != position;
  }
}
