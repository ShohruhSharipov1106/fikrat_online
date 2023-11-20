import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
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
      padding: EdgeInsets.fromLTRB(0, 8, 0, MediaQuery.of(context).viewPadding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (navBar.unSelectedIcon.contains('http') && navBar.unSelectedIcon.isNotEmpty) ...{
            CachedNetworkImage(
              imageUrl: navBar.unSelectedIcon,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    border: Border.all(color: currentIndex == navBar.id ? mainColor : Colors.transparent, width: 1.5),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Center(
                  child: SvgPicture.asset(
                    currentIndex == navBar.id ? AppIcons.activeUser : AppIcons.defaultAvatar,
                    height: 24,
                    width: 24,
                  ),
                );
              },
              placeholder: (context, url) {
                return Center(
                  child: SvgPicture.asset(
                    currentIndex == navBar.id ? AppIcons.activeUser : AppIcons.defaultAvatar,
                    height: 24,
                    width: 24,
                  ),
                );
              },
            ),
          } else ...{
            Center(
              child: SvgPicture.asset(
                currentIndex == navBar.id ? navBar.selectedIcon : navBar.unSelectedIcon,
                height: 24,
                width: 24,
              ),
            ),
          },
          const SizedBox(height: 4),
          Container(
            alignment: Alignment.bottomCenter,
            child: BlocBuilder<LocalesBloc, LocalesState>(
              builder: (context, state) {
                return Text(
                  context.read<LocalesBloc>().translate(navBar.title),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: currentIndex == navBar.id
                      ? Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 10)
                      : Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
