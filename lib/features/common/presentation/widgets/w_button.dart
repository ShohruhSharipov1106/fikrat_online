import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/network_locales/locales_bloc/locales_bloc.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_scale_animation.dart';

class WButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Color? color;
  final Color textColor;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final GestureTapCallback onTap;
  final BoxBorder? border;
  final double borderRadius;
  final Widget? child;
  final Color disabledButtonColor;
  final bool isDisabled;
  final bool isLoading;
  final double? scaleValue;
  final List<BoxShadow>? shadow;
  final Gradient? gradient;
  final int maxLines;

  const WButton({
    required this.onTap,
    this.child,
    this.text = '',
    this.color = mainColor,
    this.textColor = white,
    this.borderRadius = 10,
    this.disabledButtonColor = linkWater,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.textStyle,
    this.border,
    this.scaleValue,
    this.shadow,
    this.maxLines = 2,
    this.gradient,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      scaleValue: scaleValue ?? 0.98,
      onTap: () {
        if (!(isLoading || isDisabled)) {
          onTap();
        }
      },
      isDisabled: isDisabled || isLoading,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height ?? 40,
        margin: margin,
        padding: padding ?? EdgeInsets.zero,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDisabled ? linkWater : color,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          gradient: gradient,
          boxShadow: shadow,
        ),
        child: isLoading
            ? const Center(child: CupertinoActivityIndicator(color: white))
            : AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: isDisabled ? baliHali : white),
                child: child ??
                    BlocBuilder<LocalesBloc, LocalesState>(
                      builder: (context, state) {
                        return Text(
                          context.read<LocalesBloc>().translate(text),
                          style: textStyle,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: maxLines,
                        );
                      },
                    ),
              ),
      ),
    );
  }
}
