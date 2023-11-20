import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/assets/network_locales/locales_bloc/locales_bloc.dart';
import 'package:fikrat_online/assets/network_locales/locales_bloc/locales_bloc.dart';

class MessageContainer extends StatelessWidget {
  final String message;
  final bool isSuccess;
  final bool isDislikeMessage;
  final Widget? actions;

  const MessageContainer({
    required this.message,
    this.isSuccess = false,
    this.isDislikeMessage = false,
    this.actions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xff101012),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: white.withOpacity(.06), width: 0.5),
      ),
      child: Row(
        children: [
          if (isSuccess) ...{
            SvgPicture.asset(AppIcons.tickCircle)
          } else if (isDislikeMessage) ...{
            SvgPicture.asset(AppIcons.infoCircle)
          } else ...{
            SvgPicture.asset(AppIcons.danger)
          },
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          if (actions != null) ...{actions!},
        ],
      ),
    );
  }
}
