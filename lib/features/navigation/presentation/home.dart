import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/features/common/presentation/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:fikrat_online/features/common/presentation/bloc/deep_link_bloc/deep_link_bloc.dart';
import 'package:fikrat_online/features/common/presentation/widgets/connection_bottom_sheet.dart';
import 'package:fikrat_online/features/navigation/domain/entities/navbar.dart';
import 'package:fikrat_online/features/navigation/presentation/bloc/home_bloc.dart';
import 'package:fikrat_online/features/navigation/presentation/navigator.dart';
import 'package:fikrat_online/features/navigation/presentation/widgets/nav_bar_item.dart';

enum NavItemEnum {
  home,
  search,
  live,
  saved,
  profile,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Route route() =>
      CupertinoPageRoute<void>(builder: (_) => const HomeScreen());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _controller;
  late HomeBloc homeBloc;
  final Map<NavItemEnum, GlobalKey<NavigatorState>> _navigatorKeys = {
    NavItemEnum.home: GlobalKey<NavigatorState>(),
    NavItemEnum.search: GlobalKey<NavigatorState>(),
    NavItemEnum.live: GlobalKey<NavigatorState>(),
    NavItemEnum.saved: GlobalKey<NavigatorState>(),
    NavItemEnum.profile: GlobalKey<NavigatorState>(),
  };

  late List<NavBar> lables;

  int _currentIndex = 0;

  @override
  void initState() {
    lables = [
      const NavBar(
        // TODO LOCALE
        title: "Bosh sahifa",
        id: 0,
        // TODO CHANGE ICONS FOR HOME
        unSelectedIcon: AppIcons.home,
        selectedIcon: AppIcons.home,
      ),
      const NavBar(
        // TODO LOCALE
        title: "Qidiruv",
        id: 1,
        // TODO CHANGE ICONS FOR SEARCH
        unSelectedIcon: AppIcons.search,
        selectedIcon: AppIcons.search,
      ),
      const NavBar(
        // TODO LOCALE
        title: "Jonli efir",
        id: 2,
        // TODO CHANGE ICONS FOR LIVE
        unSelectedIcon: AppIcons.liveIcon,
        selectedIcon: AppIcons.liveIcon,
      ),
      const NavBar(
        // TODO LOCALE
        title: "Saqlanmalar",
        id: 3,
        // TODO CHANGE ICONS FOR SAVED
        unSelectedIcon: AppIcons.calendar,
        selectedIcon: AppIcons.calendar,
      ),
      const NavBar(
        // TODO LOCALE
        title: "Profil",
        id: 4,
        // TODO CHANGE ICONS FOR PROFILE
        unSelectedIcon: AppIcons.logout,
        selectedIcon: AppIcons.person,
      ),
    ];
    _controller = TabController(
        length: 4,
        vsync: this,
        animationDuration: const Duration(milliseconds: 0));

    _controller.addListener(onTabChange);

    homeBloc = HomeBloc();
    super.initState();
  }

  void onTabChange() {
    setState(() => _currentIndex = _controller.index);
  }

  Widget _buildPageNavigator(NavItemEnum tabItem) => TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
        homeBloc: homeBloc,
      );

  void changePage(int index) {
    setState(() => _currentIndex = index);
    _controller.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return HomeTabControllerProvider(
      controller: _controller,
      child: WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await _navigatorKeys[NavItemEnum.values[_currentIndex]]!
                  .currentState!
                  .maybePop();
          if (isFirstRouteInCurrentTab) {
            if (NavItemEnum.values[_currentIndex] != NavItemEnum.home) {
              changePage(0);
              return false;
            }
          }
          return isFirstRouteInCurrentTab;
        },
        child: BlocProvider.value(
          value: homeBloc,
          child: MultiBlocListener(
            listeners: [
              BlocListener<ConnectivityBloc, ConnectivityState>(
                listenWhen: (state1, state2) {
                  return state1.connected != state2.connected;
                },
                listener: (context, state) {
                  if (!state.connected) {
                    showConnectionBottomSheet(context);
                  }
                },
              ),
              BlocListener<DeepLinkBloc, DeepLinkState>(
                listener: (context, state) async {
                  // if (state is DeepLinkTriggeredState) {
                  //   switch (state.type) {
                  //     case 'project':
                  //       if (state.link.isNotEmpty) {
                  //         Navigator.of(context).push(
                  //           MaterialWithModalsPageRoute(
                  //             builder: (_) => SingleDonationPage(
                  //               id: state.link,
                  //             ),
                  //           ),
                  //         );
                  //       }
                  //       break;
                  //     case 'company':
                  //       if (state.link.isNotEmpty) {
                  //         Navigator.of(context).push(
                  //           MaterialWithModalsPageRoute(
                  //             builder: (_) => FondsSinglePage(
                  //               id: state.link,
                  //             ),
                  //           ),
                  //         );
                  //       }
                  //       break;
                  //   }
                  // }
                },
              ),
            ],
            child: AnnotatedRegion(
              value: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                bottomNavigationBar: Container(
                  // height: 48 + MediaQuery.paddingOf(context).bottom,
                  decoration: const BoxDecoration(color: white),
                  child: TabBar(
                    indicator: const BoxDecoration(),
                    padding: EdgeInsets.zero,
                    onTap: (index) async {
                      if (_controller.index == 0) {
                        homeBloc.add(const MoveToTopEvent());
                      }
                    },
                    controller: _controller,
                    labelPadding: EdgeInsets.zero,
                    tabs: List.generate(
                      lables.length,
                      (index) => NavItemWidget(
                        navBar: lables[index],
                        currentIndex: _currentIndex,
                      ),
                    ),
                  ),
                ),
                body: TabBarView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildPageNavigator(NavItemEnum.home),
                    _buildPageNavigator(NavItemEnum.search),
                    _buildPageNavigator(NavItemEnum.live),
                    _buildPageNavigator(NavItemEnum.saved),
                    _buildPageNavigator(NavItemEnum.profile),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTabControllerProvider extends InheritedWidget {
  final TabController controller;

  const HomeTabControllerProvider({
    Key? key,
    required Widget child,
    required this.controller,
  }) : super(key: key, child: child);

  static HomeTabControllerProvider of(BuildContext context) {
    final HomeTabControllerProvider? result =
        context.dependOnInheritedWidgetOfExactType<HomeTabControllerProvider>();
    assert(result != null, 'No HomeTabControllerProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(HomeTabControllerProvider oldWidget) => false;
}
