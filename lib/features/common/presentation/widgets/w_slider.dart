import 'package:flutter/material.dart';

class WSlider extends StatelessWidget {
  final double max;
  final double min;
  final double value;
  final ValueChanged<double>? onChanged;
  final SliderThemeData? data;

  const WSlider({
    Key? key,
    this.max = 1,
    this.min = 0,
    this.value = 0,
    required this.onChanged,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: data == null
          ? const SliderThemeData().copyWith(trackShape: _CustomTrackShape())
          : data!.copyWith(trackShape: _CustomTrackShape()),
      child: Slider(max: max, min: min, value: value, onChanged: onChanged),
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
