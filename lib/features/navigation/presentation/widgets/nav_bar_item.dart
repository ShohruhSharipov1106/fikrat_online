import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fikrat_online/features/navigation/domain/entities/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavItemWidget extends StatelessWidget {
  final int currentIndex;
  final NavBar navBar;

  const NavItemWidget({
    required this.navBar,
    required this.currentIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(
          0, 8, 0, MediaQuery.of(context).viewPadding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: SvgPicture.asset(
              currentIndex == navBar.id
                  ? navBar.selectedIcon
                  : navBar.unSelectedIcon,
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              navBar.title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: currentIndex == navBar.id
                  ? Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontSize: 10)
                  : Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
