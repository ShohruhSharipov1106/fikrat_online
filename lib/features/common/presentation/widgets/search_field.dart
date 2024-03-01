import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:fikrat_online/generated/locale_keys.g.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<bool>? onClear;
  final Color fillColor;
  final FocusNode? focusNode;
  final double borderRadius;
  final GlobalKey<FormState>? stateKey;
  final bool hasBorder;
  final bool focus;
  final TextStyle? textStyle;
  final double height;
  final bool readOnly;
  final Color focusedBorderColor;
  const SearchField({
    this.focusNode,
    this.stateKey,
    required this.controller,
    required this.onChanged,
    required this.onFieldSubmitted,
    this.borderRadius = 8,
    this.fillColor = white,
    Key? key,
    this.hasBorder = true,
    this.focus = false,
    this.textStyle,
    this.height = 36,
    this.readOnly = false,
    this.onClear,
    this.focusedBorderColor = mainColor,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController _controller;
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();

    _controller = widget.controller..addListener(textFieldListener);

    super.initState();
  }

  void textFieldListener() {
    if (widget.controller.text.length < 2) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(textFieldListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        readOnly: widget.readOnly,
        cursorHeight: 20,
        cursorColor: black,
        cursorWidth: 1,
        autofocus: widget.focus,
        key: widget.stateKey,
        focusNode: focusNode,
        controller: _controller,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        textInputAction: TextInputAction.search,
        style: widget.textStyle ??
            Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          fillColor: focusNode.hasFocus ? widget.fillColor : ghost,
          filled: true,
          suffixIconConstraints: const BoxConstraints(maxWidth: 40),
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
            child: Center(
              child: SvgPicture.asset(
                AppIcons.search,
                width: 20,
                height: 20,
                fit: BoxFit.cover,
                color: tabGrey,
              ),
            ),
          ),
          hintText: LocaleKeys.search,
          hintStyle: Theme.of(context).textTheme.titleMedium,
          prefixIconConstraints: const BoxConstraints(maxWidth: 40),
          suffixIcon: _controller.text.isNotEmpty
              ? WScaleAnimation(
                  onTap: () {
                    setState(() {
                      _controller.clear();
                    });
                    widget.onClear == null ? null : widget.onClear!(true);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 12, 0),
                    child: SvgPicture.asset(AppIcons.clear),
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.hasBorder ? ghost : Colors.transparent,
              width: 1.6,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide:
                BorderSide(color: widget.focusedBorderColor, width: 1.6),
          ),
        ),
      ),
    );
  }
}
