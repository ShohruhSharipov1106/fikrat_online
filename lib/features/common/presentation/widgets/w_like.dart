import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fikrat_online/assets/constants/icons.dart';

class WLike extends StatefulWidget {
  final bool? initialLike;
  final Widget? activeIcon;
  final Widget? inActiveIcon;
  final BoxFit? fit;
  final VoidCallback? onTap;
  final bool isFromWishlisted;
  final Color? inActiveColor;
  final bool? changeAfterTappedValue;

  const WLike({
    this.initialLike,
    this.activeIcon,
    this.inActiveIcon,
    this.fit,
    this.onTap,
    this.isFromWishlisted = false,
    this.inActiveColor,
    this.changeAfterTappedValue,
    Key? key,
  }) : super(key: key);

  @override
  State<WLike> createState() => _WLikeState();
}

class _WLikeState extends State<WLike> {
  late bool isLiked;

  @override
  void initState() {
    if (widget.initialLike != null) {
      isLiked = widget.initialLike!;
    }
    isLiked = widget.initialLike ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isFromWishlisted) {
      isLiked = widget.initialLike ?? false;
    }
    if (widget.changeAfterTappedValue != null) {
      isLiked = widget.changeAfterTappedValue ?? false;
    }
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }

        isLiked = !isLiked;

        setState(() {});
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: isLiked
            ? widget.activeIcon ??
                SvgPicture.asset(
                  AppIcons.activeBookmark,
                  key: const ValueKey<int>(1),
                )
            : widget.inActiveIcon ??
                SvgPicture.asset(
                  AppIcons.bookmark,
                  key: const ValueKey<int>(2),
                  color: widget.inActiveColor,
                ),
      ),
    );
  }
}
