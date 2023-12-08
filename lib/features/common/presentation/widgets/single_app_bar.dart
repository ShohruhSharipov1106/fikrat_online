import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/assets/network_locales/locales_bloc/locales_bloc.dart';

class SingleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? actionIcon;
  final Color backgroundColor;
  final void Function()? leadingFunction;

  const SingleAppBar({
    Key? key,
    this.actionIcon,
    required this.title,
    this.leadingFunction,
    this.backgroundColor = white,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: backgroundColor,
      leading: IconButton(
        onPressed: leadingFunction ??
            () {
              Navigator.of(context).pop();
            },
        icon: SvgPicture.asset(
          AppIcons.arrowLeft,
          colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
        ),
      ),
      title: BlocBuilder<LocalesBloc, LocalesState>(
        builder: (context, state) {
          return Text(
            context.read<LocalesBloc>().translate(title),
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16),
          );
        },
      ),
      actions: actionIcon != null ? [actionIcon!] : null,
    );
  }
}
