import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:formz/formz.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/features/common/domain/entities/static_page_detail_entity.dart';
import 'package:fikrat_online/features/common/domain/usecase/get_static_page_usecase.dart';
import 'package:fikrat_online/features/common/presentation/bloc/get_offer_bloc/offerta_bloc.dart';
import 'package:fikrat_online/features/common/presentation/widgets/bottom_sheet_header.dart';
import 'package:fikrat_online/generated/locale_keys.g.dart';

class OffertaPage extends StatefulWidget {
  final String? title;
  final String? content;

  const OffertaPage({this.title, this.content, Key? key}) : super(key: key);

  @override
  State<OffertaPage> createState() => _OffertaPageState();
}

class _OffertaPageState extends State<OffertaPage> {
  late OffertaBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = OffertaBloc()..add(const GetStaticPage(params: GetStaticPageParams(search: "commeta-hissa")));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(systemNavigationBarColor: solitude1),
      child: BlocProvider.value(
        value: bloc,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomSheetHeader(
                  title: widget.title ?? LocaleKeys.big_pub_oferta,
                  hasArrowLeft: false,
                  centerTitle: true,
                ),
                Expanded(
                  child: BlocBuilder<OffertaBloc, OffertaState>(
                    builder: (context, state) {
                      if (state.staticPageStatus == FormzSubmissionStatus.inProgress) {
                        return const Center(child: CircularProgressIndicator.adaptive());
                      } else if (state.staticPageStatus == FormzSubmissionStatus.success) {
                        if (state.content == const StaticPageDetailEntity() &&
                            state.status != FormzSubmissionStatus.failure) {
                          bloc.add(GetOfferta(type: state.searchedType));
                        }
                        if (state.status == FormzSubmissionStatus.inProgress) {
                          return const Center(child: CircularProgressIndicator.adaptive());
                        } else if (state.staticPageStatus == FormzSubmissionStatus.success) {
                          log("content => ${state.content.content}");
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: Scrollbar(
                              radius: const Radius.circular(20),
                              thickness: 8,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Html(
                                  data: widget.content ?? state.content.content,
                                  style: {
                                    'p': Style(
                                      fontSize: FontSize.medium,
                                      color: gordonsGreen,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    'h2': Style(
                                      fontSize: FontSize.larger,
                                      color: gordonsGreen,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  },
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Text('Something went wrong');
                        }
                      } else {
                        return const Text('Something went wrong');
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
