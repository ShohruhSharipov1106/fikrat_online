import 'package:fikrat_online/features/live_stream/live_stream_screen.dart';
import 'package:fikrat_online/features/profile/profile_screen.dart';
import 'package:fikrat_online/features/saveds/saveds_screen.dart';
import 'package:fikrat_online/features/search/search_screen.dart';
import 'package:fikrat_online/features/navigation/presentation/bloc/home_bloc.dart';
import 'package:fikrat_online/features/navigation/presentation/home.dart';
import 'package:flutter/material.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

class TabNavigator extends StatefulWidget {
  final HomeBloc homeBloc;
  final GlobalKey<NavigatorState> navigatorKey;
  final NavItemEnum tabItem;

  const TabNavigator(
      {required this.tabItem,
      required this.navigatorKey,
      required this.homeBloc,
      Key? key})
      : super(key: key);

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>
    with AutomaticKeepAliveClientMixin {
  Map<String, WidgetBuilder> _routeBuilders(
      {required BuildContext context, required RouteSettings routeSettings}) {
    switch (widget.tabItem) {
      case NavItemEnum.home:
        return {
          TabNavigatorRoutes.root: (context) => HomeScreen(),
        };
      case NavItemEnum.search:
        return {
          TabNavigatorRoutes.root: (context) => const SearchScreen(),
        };
      case NavItemEnum.live:
        return {
          TabNavigatorRoutes.root: (context) => const LiveStreamScreen(),
        };
      case NavItemEnum.saved:
        return {
          TabNavigatorRoutes.root: (context) => const SavedsScreen(),
        };
      case NavItemEnum.profile:
        return {
          TabNavigatorRoutes.root: (context) => const ProfileScreen(),
        };
      default:
        return {
          TabNavigatorRoutes.root: (context) => Container(),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        final routeBuilders =
            _routeBuilders(context: context, routeSettings: routeSettings);
        return MaterialPageRoute(
          builder: (context) => routeBuilders.containsKey(routeSettings.name)
              ? routeBuilders[routeSettings.name]!(context)
              : Container(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => false;
}
