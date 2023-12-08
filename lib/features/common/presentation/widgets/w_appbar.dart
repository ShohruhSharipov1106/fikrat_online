import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/assets/network_locales/locales_bloc/locales_bloc.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_scale_animation.dart';

class WAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onActionTap;
  final Widget action;
  final String title;
  final Widget? titleWidget;
  final String leadingLogo;
  final bool hasBackButton;
  final bool hasElevation;

  const WAppBar(
      {required this.title,
      required this.action,
      this.titleWidget,
      required this.leadingLogo,
      required this.onActionTap,
      this.hasBackButton = false,
      this.hasElevation = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top,
          right: 0,
          bottom: 0,
          left: 12,
        ),
        decoration: BoxDecoration(
          color: white,
          // boxShadow: hasElevation ? aliminuimBoxShadow : [],
        ),
        child: Row(
          children: [
            if (hasBackButton) ...{
              WScaleAnimation(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: SvgPicture.asset(
                    AppIcons.arrowLeft,
                    colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            } else ...{
              SvgPicture.asset(leadingLogo),
            },
            const SizedBox(width: 8),
            if (titleWidget != null) ...{
              titleWidget!
            } else ...{
              if (title.isNotEmpty) ...{
                BlocBuilder<LocalesBloc, LocalesState>(
                  builder: (context, state) {
                    return Text(
                      context.read<LocalesBloc>().translate(title),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 20,
                          ),
                    );
                  },
                ),
              },
            },
            const Spacer(),
            WScaleAnimation(
              onTap: onActionTap,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: action,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 52);
}
