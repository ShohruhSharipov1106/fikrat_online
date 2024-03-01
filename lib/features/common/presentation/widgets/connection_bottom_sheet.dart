import 'package:fikrat_online/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/features/common/presentation/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:fikrat_online/features/common/presentation/widgets/small_container.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_button.dart';

showConnectionBottomSheet(BuildContext context) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      isDismissible: true,
      context: context,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (c) {
        return const ConnectionBottomSheet();
      });
}

class ConnectionBottomSheet extends StatelessWidget {
  const ConnectionBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: BlocListener<ConnectivityBloc, ConnectivityState>(
          listener: (context, state) {
            if (state.connected) {
              Navigator.pop(context);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SmallContainer(),
              Container(
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                padding: EdgeInsets.fromLTRB(
                  12,
                  24,
                  12,
                  12 + MediaQuery.paddingOf(context).bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),
                    SvgPicture.asset(
                      AppIcons.networkError,
                      width: 150,
                      height: 133,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      LocaleKeys.net_break,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      LocaleKeys.check_net,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.w400),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    WButton(
                      onTap: () {
                        // AppSettings.openWIFISettings();
                      },
                      height: 40,
                      color: mainColor,
                      text: LocaleKeys.update,
                      textStyle: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
