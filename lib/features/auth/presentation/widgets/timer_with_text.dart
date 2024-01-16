import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/features/auth/presentation/widgets/refresh_button.dart';
import 'package:fikrat_online/features/auth/presentation/widgets/time_counter.dart';
import 'package:flutter/material.dart';
import 'package:fikrat_online/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class TimerWithText extends StatefulWidget {
  final bool isDark;
  final bool isDarkRefresh;
  final Function(VoidCallback onSucces) postAction;

  const TimerWithText({
    required this.postAction,
    this.isDarkRefresh = true,
    this.isDark = true,
    Key? key,
  }) : super(key: key);

  @override
  State<TimerWithText> createState() => _TimerWithTextState();
}

class _TimerWithTextState extends State<TimerWithText> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isCompleted)
          RefreshButton(
            isDarkRefresh: widget.isDarkRefresh,
            onTap: (void Function() onSuccess) {
              widget.postAction(onSuccess);
              setState(() {
                isCompleted = false;
              });
            },
          )
        else
          Row(
            children: [
              Text(
                '${LocaleKeys.resend.tr()}:',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: widget.isDark ? disabledButtonWithOpacity6 : tiber,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                width: 6,
              ),
              Container(
                width: 60,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: widget.isDark
                          ? mainColorWithOpacity1
                          : disabledButton),
                  color: widget.isDark
                      ? phoneFillColorWithOpacity06
                      : scaffoldBackground,
                ),
                child: TimeCounter(
                  isDarkRefresh: widget.isDarkRefresh,
                  onComplete: () {
                    setState(() {
                      isCompleted = true;
                    });
                  },
                ),
              ),
            ],
          )
      ],
    );
  }
}
