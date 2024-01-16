import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';
import 'package:fikrat_online/core/data/singletons/dio_settings.dart';
import 'package:fikrat_online/core/data/singletons/service_locator.dart';
import 'package:fikrat_online/core/data/singletons/storage.dart';
import 'package:fikrat_online/features/auth/presentation/widgets/language_item.dart';
import 'package:fikrat_online/features/common/presentation/widgets/small_container.dart';
import 'package:fikrat_online/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:fikrat_online/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LanguageLayout extends StatefulWidget {
  final ValueChanged<LanguageModel> onChanged;

  const LanguageLayout({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<LanguageLayout> createState() => _LanguageLayoutState();
}

class _LanguageLayoutState extends State<LanguageLayout> {
  late List<String> languageTitle = [
    'O‘zbekcha',
    'Ўзбекча',
    'Русский',
    'English',
    'Qaraqalpaqsha',
  ];
  late List<String> keys = [
    'uz',
    'uk',
    'ru',
    'en',
    'ka',
  ];
  late List<String> languageFlag = [
    AppIcons.uzb,
    AppIcons.uzb,
    AppIcons.rus,
    AppIcons.eng,
    AppIcons.qq,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SmallContainer(),
        Container(
          decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      LocaleKeys.app_lan.tr(),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  const Spacer(),
                  WScaleAnimation(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                      child: SvgPicture.asset(AppIcons.close),
                    ),
                  )
                ],
              ),
              Container(
                color: disabledButton,
                height: 1,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                  margin: const EdgeInsets.only(
                      left: 16, right: 16, top: 18, bottom: 6),
                  decoration: BoxDecoration(
                      color: disabledButton,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: languageFlag.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(
                      margin: const EdgeInsets.only(left: 44),
                      color: baliHai.withOpacity(0.1),
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return LanguageItem(
                        onTap: (value) async {
                          widget.onChanged(LanguageModel(
                            title: value.title,
                            flag: value.flag,
                            keys: value.keys,
                          ));
                          context.setLocale(Locale(value.keys));
                          setState(() {});
                          // TODO UNCOMMENT
                          // serviceLocator<DioSettings>()
                          //     .setBaseOptions(lang: value.keys);
                          // setupLocator();
                          StorageRepository.putString(
                              StoreKeys.language, value.keys);
                          Navigator.pop(context);
                        },
                        title: languageTitle[index],
                        icon: languageFlag[index],
                        keys: keys[index],
                      );
                    },
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class LanguageModel {
  final String title;
  final String flag;
  final String keys;

  const LanguageModel({
    required this.title,
    required this.flag,
    required this.keys,
  });
}
