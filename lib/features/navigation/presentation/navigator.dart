import 'package:flutter_bloc/flutter_bloc.dart';
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

  const TabNavigator({required this.tabItem, required this.navigatorKey, required this.homeBloc, Key? key})
      : super(key: key);

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> with AutomaticKeepAliveClientMixin {
  Map<String, WidgetBuilder> _routeBuilders({required BuildContext context, required RouteSettings routeSettings}) {
    switch (widget.tabItem) {
      case NavItemEnum.home:
        return {
          TabNavigatorRoutes.root: (context) => BlocProvider(
                create: (_) => widget.homeBloc,
                child: HomePage(kontext: context),
              ),
        };
      case NavItemEnum.fonds:
        return {
          TabNavigatorRoutes.root: (context) => const FondsPage(),
        };
      case NavItemEnum.reports:
        return {
          TabNavigatorRoutes.root: (context) => const ReportsPage(),
        };
      case NavItemEnum.profile:
        return {
          TabNavigatorRoutes.root: (context) => const ProfilePage(),
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
        final routeBuilders = _routeBuilders(context: context, routeSettings: routeSettings);
        return MaterialPageRoute(
          builder: (context) =>
              routeBuilders.containsKey(routeSettings.name) ? routeBuilders[routeSettings.name]!(context) : Container(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => false;
}
