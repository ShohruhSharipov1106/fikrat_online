import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/network_locales/locales_bloc/locales_bloc.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final EdgeInsets contentPadding;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final double prefixMaxWidth;
  final double suffixMaxWidth;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? hintText;
  final bool hasError;
  final bool isObscure;
  final InputDecoration? inputDecoration;
  final TextInputType? keyboardType;
  final String title;
  final double? height;
  final int? maxLines;
  final int? maxLength;
  final bool autoFocus;
  final FocusNode? focusNode;
  final TextAlignVertical? textAlignVertical;
  final bool? expands;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool showCount;
  final TextInputAction? textInputAction;
  final Color fillColor;
  final Color cursorColor;
  final Color focusColor;
  final Color enabledBorder;
  final bool readOnly;
  final String? Function(String?)? validator;
  final bool hasSuffixIcon;
  final String? counterText;
  final TextStyle? titleStyle;
  final double borderRadius;
  final BoxConstraints? constraints;
  final Color? fullFieldColor;
  final double? fullFieldBorder;
  final int? minLines;

  const DefaultTextField({
    this.autoFocus = false,
    this.hasSuffixIcon = false,
    this.showCount = false,
    this.readOnly = false,
    this.focusNode,
    this.textInputAction,
    this.maxLengthEnforcement,
    this.validator,
    this.counterText = '',
    required this.controller,
    required this.onChanged,
    this.prefix,
    this.title = '',
    this.borderRadius = 10,
    this.contentPadding = const EdgeInsets.all(12),
    this.inputFormatters,
    this.suffix,
    this.prefixMaxWidth = 40,
    this.suffixMaxWidth = 40,
    this.hintStyle,
    this.hintText,
    this.style,
    this.isObscure = false,
    this.hasError = false,
    this.inputDecoration,
    this.keyboardType,
    this.height,
    this.maxLines,
    this.maxLength,
    this.minLines = 1,
    this.textAlignVertical,
    this.expands,
    this.fillColor = whiteSmoke,
    this.cursorColor = dark,
    this.focusColor = blue,
    this.enabledBorder = whiteSmoke,
    this.fullFieldBorder,
    this.fullFieldColor,
    this.titleStyle,
    this.constraints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalesBloc, LocalesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title.isNotEmpty) ...[
              Text(context.read<LocalesBloc>().translate(title),
                  style: titleStyle ?? Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
            ],
            Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(fullFieldBorder ?? 0),
                color: fullFieldColor,
              ),
              child: TextFormField(
                minLines: minLines,
                readOnly: readOnly,
                expands: expands ?? false,
                maxLengthEnforcement: maxLengthEnforcement,
                textAlignVertical: textAlignVertical,
                focusNode: focusNode,
                autofocus: autoFocus,
                controller: controller,
                onChanged: onChanged,
                validator: validator,
                textInputAction: textInputAction,
                style: style ?? Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14),
                inputFormatters: inputFormatters,
                obscureText: isObscure,
                keyboardType: keyboardType,
                maxLength: maxLength,
                maxLines: isObscure ? 1 : maxLines,
                cursorColor: cursorColor,
                cursorWidth: 1,
                cursorHeight: 20,
                decoration: inputDecoration ??
                    InputDecoration(
                      constraints: constraints,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: const BorderSide(color: red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(
                          color: hasError ? red : enabledBorder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        borderSide: BorderSide(color: hasError ? red : focusColor),
                      ),
                      hintText: context.read<LocalesBloc>().translate(hintText ?? ''),
                      hintStyle: hintStyle ?? Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
                      contentPadding: contentPadding,
                      suffixIconConstraints: BoxConstraints(maxWidth: suffixMaxWidth),
                      suffixIcon: hasSuffixIcon
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: suffix,
                            ),
                      fillColor: fillColor,
                      filled: true,
                      prefixIconConstraints: BoxConstraints(maxWidth: prefixMaxWidth),
                      prefixIcon: prefix,
                      counterText: counterText,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
