import 'dart:async';

import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:flutter/material.dart';

class TimeCounter extends StatefulWidget {
  final TextStyle? textStyle;
  final bool isDarkRefresh;
  final VoidCallback onComplete;

  const TimeCounter(
      {Key? key,
      required this.onComplete,
      this.textStyle,
      required this.isDarkRefresh})
      : super(key: key);

  @override
  State<TimeCounter> createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  late Timer secondsTimer;
  int secondS = 120;
  final _streamController = StreamController<int>.broadcast(sync: true);

  @override
  void initState() {
    secondsTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondS == 0) {
        _streamController.close();
        secondsTimer.cancel();
      } else {
        secondS--;
        _streamController.add(secondS);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (secondsTimer.isActive) {
      secondsTimer.cancel();
    }
    super.dispose();
  }

  String printTime(int timeLeft) {
    final minutesLeft = timeLeft ~/ 60;
    final secondsLeft = timeLeft % 60;
    return '0$minutesLeft:${secondsLeft < 10 ? '0$secondsLeft' : secondsLeft}';
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<int>(
        stream: _streamController.stream
          ..listen((event) {}, onDone: widget.onComplete),
        initialData: 120,
        builder: (context, duration) => Text(printTime(duration.data as int),
            style: widget.textStyle ??
                Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: widget.isDarkRefresh ? white : tiber)),
      );
}
