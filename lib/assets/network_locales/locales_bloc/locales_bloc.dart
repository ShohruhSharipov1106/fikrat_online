import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:fikrat_online/assets/constants/app_constants.dart';
import 'package:fikrat_online/assets/network_locales/data/datasource/locale_datasource.dart';
import 'package:fikrat_online/assets/network_locales/data/repository/locale_repository_impl.dart';
import 'package:fikrat_online/core/data/singletons/storage.dart';
import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/utils/my_functions.dart';
import 'package:fikrat_online/assets/network_locales/domain/usecases/get_locales_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'locales_event.dart';
part 'locales_state.dart';

class LocalesBloc extends Bloc<LocalesEvent, LocalesState> {
  final GetLocaleUseCase getLocaleUseCase = GetLocaleUseCase(
      repository: LocaleRepositoryImpl(
    dataSource: LocaleDataSourceImpl(Dio(
      BaseOptions(
        baseUrl: AppConstants.BASE_URL_DEV,
        connectTimeout: const Duration(milliseconds: 35000),
        receiveTimeout: const Duration(milliseconds: 33000),
        followRedirects: false,
        headers: <String, dynamic>{
          'Accept-Language':
              StorageRepository.getString(StoreKeys.language, defValue: 'uz')
        },
        validateStatus: (status) => status != null && status <= 500,
      ),
    )),
  ));
  LocalesBloc() : super(const LocalesState()) {
    on<GetLocalesEvent>(_getLocalesEvent);
  }

  _getLocalesEvent(GetLocalesEvent event, Emitter<LocalesState> emit) async {
    final response = await Dio(
      BaseOptions(
        baseUrl: AppConstants.BASE_URL_DEV,
        connectTimeout: const Duration(milliseconds: 35000),
        receiveTimeout: const Duration(milliseconds: 33000),
        followRedirects: false,
        headers: <String, dynamic>{
          'Accept-Language':
              StorageRepository.getString(StoreKeys.language, defValue: 'uz')
        },
        validateStatus: (status) => status != null && status <= 500,
      ),
    ).get(
        "/FrontendTranslation/${StorageRepository.getString(StoreKeys.language, defValue: 'uz')}/",
        queryParameters: {"source": "care_mobile"});
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      emit(state.copyWith(locales: response.data as Map<String, dynamic>));
      event.onSuccess();
    } else {
      emit(
        state.copyWith(locales: defaultLocales),
      );
      event.onError();
      throw ServerException(
        statusCode: response.statusCode ?? 400,
        errorMessage: MyFunctions.getErrorMessage(response: response.data),
      );
    }
  }

  String translate(String key) {
    if (state.locales.isEmpty) {
      add(GetLocalesEvent(onSuccess: () {}, onError: () {}));
    }
    return state.locales["care_mobile_$key"] ?? key;
  }
}

final Map<String, dynamic> defaultLocales = {
  "care_mobile_confirm": "confirm",
  "care_mobile_continued": "continued",
  "care_mobile_big_pub_oferta": "big_pub_oferta",
  "care_mobile_resend": "resend",
  "care_mobile_january": "january",
  "care_mobile_february": "february",
  "care_mobile_march": "march",
  "care_mobile_april": "april",
  "care_mobile_may": "may",
  "care_mobile_june": "june",
  "care_mobile_july": "july",
  "care_mobile_august": "august",
  "care_mobile_september": "september",
  "care_mobile_october": "october",
  "care_mobile_november": "november",
  "care_mobile_december": "december",
  "care_mobile_no_result": "no_result",
  "care_mobile_no_result_to_you": "no_result_to_you",
  "care_mobile_filter": "filter",
  "care_mobile_close": "close",
  "care_mobile_are_approve": "are_approve",
  "care_mobile_cancel": "cancel",
  "care_mobile_all": "all",
  "care_mobile_use": "use",
  "care_mobile_ta": "ta",
  "care_mobile_clear": "clear",
  "care_mobile_other_category": "other_category",
  "care_mobile_main": "main",
  "care_mobile_try_again": "try_again",
  "care_mobile_add_cart": "add_cart",
  "care_mobile_cart_number": "cart_number",
  "care_mobile_validity_period": "validity_period",
  "care_mobile_carts": "carts",
  "care_mobile_not_cart": "not_cart",
  "care_mobile_not_money": "not_money",
  "care_mobile_profile": "profile",
  "care_mobile_categories": "categories",
  "care_mobile_settings": "settings",
  "care_mobile_sure_logout": "sure_logout",
  "care_mobile_fonds": "fonds",
  "care_mobile_reports": "reports",
  "care_mobile_search": "search",
  "care_mobile_net_break": "net_break",
  "care_mobile_check_net": "check_net",
  "care_mobile_update": "update",
  "care_mobile_support_generosity": "support_generosity",
  "care_mobile_congrats_payment_success": "congrats_payment_success",
  "care_mobile_done_success": "done_success",
  "care_mobile_not_payed": "not_payed",
  "care_mobile_try_perform_balance": "try_perform_balance",
  "care_mobile_payment_transaction": "payment_transaction",
  "care_mobile_donation": "donation",
  "care_mobile_for_system": "for_system",
  "care_mobile_total_payment_amount": "total_payment_amount",
  "care_mobile_card_type": "card_type",
  "care_mobile_payment_status": "payment_status",
  "care_mobile_payer": "payer",
  "care_mobile_payer_status": "payer_status",
  "care_mobile_back_to_main": "back_to_main",
  "care_mobile_app_lan": "app_lan",
  "care_mobile_load_more": "load_more",
  "care_mobile_sign_to_app": "sign_to_app",
  "care_mobile_input_complaint_comment": "input_complaint_comment",
  "care_mobile_comment": "comment",
  "care_mobile_input_comment": "input_comment",
  "care_mobile_send_complaint": "send_complaint",
  "care_mobile_unfollow": "unfollow",
  "care_mobile_complain": "complain",
  "care_mobile_followers": "followers",
  "care_mobile_follow": "follow",
  "care_mobile_projects": "projects",
  "care_mobile_complaint": "complaint",
  "care_mobile_unsuccess": "unsuccess",
  "care_mobile_sent_successfully": "sent_successfully",
  "care_mobile_complaint_sent_unsuccessfully": "complaint_sent_unsuccessfully",
  "care_mobile_complaint_sent_successfully": "complaint_sent_successfully",
  "care_mobile_use_filter": "use_filter",
  "care_mobile_region": "region",
  "care_mobile_donation_type": "donation_type",
  "care_mobile_share": "share",
  "care_mobile_saveds": "saveds",
  "care_mobile_my_donations": "my_donations",
  "care_mobile_my_cards": "my_cards",
  "care_mobile_contact": "contact",
  "care_mobile_notifications": "notifications",
  "care_mobile_rules_of_offerta": "rules_of_offerta",
  "care_mobile_log_out": "log_out",
  "care_mobile_about_donation": "about_donation",
  "care_mobile_posts": "posts",
  "care_mobile_questions": "questions",
  "care_mobile_comments": "comments",
  "care_mobile_donate_anonymous": "donate_anonymous",
  "care_mobile_pay_donation_summ": "pay_donation_summ",
  "care_mobile_money_amout": "money_amout",
  "care_mobile_other_summ": "other_summ",
  "care_mobile_summ": "summ",
  "care_mobile_input_summ": "input_summ",
  "care_mobile_donate_to_develop_project": "donate_to_develop_project",
  "care_mobile_imkon_saxovat": "imkon_saxovat",
  "care_mobile_donate_to_improve_social_imkon":
      "donate_to_improve_social_imkon",
  "care_mobile_contribution": "contribution",
  "care_mobile_gained": "gained",
  "care_mobile_target": "target",
  "care_mobile_donators": "donators",
  "care_mobile_time_left_for_donation": "time_left_for_donation",
  "care_mobile_day": "day",
  "care_mobile_hour": "hour",
  "care_mobile_minute_short": "minute_short",
  "care_mobile_second_short": "second_short",
  "care_mobile_sent_otp_code_to_phone": " sent_otp_code_to_phone",
  "care_mobile_input_confirmation_code": "input_confirmation_code",
  "care_mobile_too_slow": "too_slow",
  "care_mobile_slow": "slow",
  "care_mobile_normal": "normal",
  "care_mobile_fast": "fast",
  "care_mobile_too_fast": "too_fast",
  "care_mobile_video_speed": "video_speed",
  "care_mobile_saved_was_deleted": "saved_was_deleted",
  "care_mobile_empty_saveds": "empty_saveds",
  "care_mobile_empty_saveds_subtitle": "empty_saveds_subtitle",
  "care_mobile_donators_list": "donators_list",
  "care_mobile_sure_to_delete": "sure_to_delete",
  "care_mobile_delete_card_subtitle": "delete_card_subtitle",
  "care_mobile_yes": "yes",
  "care_mobile_empty_reports_subtitle": "empty_reports_subtitle",
  "care_mobile_empty_reports": "empty_reports",
  "care_mobile_empty_fonds": "empty_fonds",
  "care_mobile_empty_fonds_subtitle": "empty_fonds_subtitle",
  "care_mobile_contact_with_call": "contact_with_call",
  "care_mobile_our_social_media": "our_social_media",
  "care_mobile_unknown_user": "unknown_user",
  "care_mobile_version": "version",
  "care_mobile_donation_projects": "donation_projects",
  "care_mobile_about_fonds": "about_fonds",
  "care_mobile_donation_monthy": "donation_monthy",
  "care_mobile_all_donations": "all_donations",
  "care_mobile_empty_donations": "empty_donations",
  "care_mobile_empty_donations_subtitle": "empty_donations_subtitle",
  "care_mobile_files": "files",
  "care_mobile_anonymous_donator": "anonymous_donator",
  "care_mobile_card_added_successfully": "card_added_successfully",
  "care_mobile_app_language": "app_language",
  "care_mobile_empty_projects": "empty_projects",
  "care_mobile_empty_projects_subtitle": "empty_projects_subtitle",
  "care_mobile_empty_card_subtitle": "empty_card_subtitle",
  "care_mobile_it_is_you": "it_is_you",
  "care_mobile_help": "help",
  "care_mobile_empty_notification": "empty_notification",
  "care_mobile_empty_notification_subtitle": "empty_notification_subtitle",
  "care_mobile_view_report": "view_report",
  "care_mobile_preparing_review": "preparing_review",
  "care_mobile_donators_comments": "donators_comments",
  "care_mobile_add": "add",
  "care_mobile_to_pay_you": "to_pay_you ",
  "care_mobile_rule_use": "rule_use",
  "care_mobile_you_agree_to": "you_agree_to",
  "care_mobile_monday": "monday",
  "care_mobile_tuesday": "tuesday",
  "care_mobile_wednesday": "wednesday",
  "care_mobile_thursday": "thursday",
  "care_mobile_friday": "friday",
  "care_mobile_saturday": "saturday",
  "care_mobile_sunday": "sunday",
  "care_mobile_route": "route",
  "care_mobile_advertise_as_fund": "advertise_as_fund",
  "care_mobile_support_company": "support_company",
  "care_mobile_support": "support",
  "care_mobile_empty_comment_subtitle": "empty_comment_subtitle",
  "care_mobile_empty_comment": "empty_comment",
  "care_mobile_empty_faq": "empty_faq",
  "care_mobile_empty_faq_subtitle": "empty_faq_subtitle",
  "care_mobile_successfully": "successfully",
  "care_mobile_unsuccessfully": "unsuccessfully",
  "care_mobile_anonymous": "anonymous",
  "care_mobile_open": "open",
  "care_mobile_pay": "pay",
  "care_mobile_send_verify_code_to_phone": "send_verify_code_to_phone",
  "care_mobile_mark_as_all_read": "mark_as_all_read",
  "care_mobile_empty_home_donations": "empty_home_donations",
  "care_mobile_empty_home_search_donations": "empty_home_search_donations",
  "care_mobile_empty_home_donations_subtitle": "empty_home_donations_subtitle",
  "care_mobile_empty_home_search_donations_subtitle":
      "empty_home_search_donations_subtitle",
  "care_mobile_only_followings": "only_followings",
  "care_mobile_add_project": "add_project",
  "care_mobile_connect_with_commeta": "connect_with_commeta",
  "care_mobile_my_followings": "my_followings",
  "care_mobile_followings": "followings",
  "care_mobile_go_to_hissa_bussiness": "go_to_hissa_bussiness",
  "care_mobile_verify_company_control_projects":
      "verify_company_control_projects",
  "care_mobile_go_to_hissa": "go_to_hissa",
  "care_mobile_search_followers": "search_followers",
  "care_mobile_empty_followers": "empty_followers",
  "care_mobile_be_first_followers": "be_first_followers",
  "care_mobile_sure_unfollow_fond": "sure_unfollow_fond",
  "care_mobile_all_projects": "all_projects",
  "care_mobile_work_graphics": "work_graphics",
  "care_mobile_empty_posts": "empty_posts",
  "care_mobile_empty_posts_subtitle": "empty_posts_subtitle",
  "care_mobile_before_days": "before_days",
  "care_mobile_before_hours": "before_hours",
  "care_mobile_before_minutes": "before_minutes",
  "care_mobile_before_seconds": "before_seconds",
  "care_mobile_open_to": "open_to",
  "care_mobile_day_off": "day_off",
  "care_mobile_donation_completed": "donation_completed",
  "care_mobile_donate": "donate",
  "care_mobile_empty_company_projects": "empty_company_projects",
  "care_mobile_empty_company_projects_subtitle":
      "empty_company_projects_subtitle",
  "care_mobile_loading_user_card": "loading_user_card",
  "care_mobile_error_loading_user_card": "error_loading_user_card",
  "care_mobile_reload": "reload",
  "care_mobile_go_to_project": "go_to_project",
  "care_mobile_understandable": "understandable",
  "care_mobile_completed_donation_amount": "completed_donation_amount",
  "care_mobile_completed_donation_amount_subtitle":
      "completed_donation_amount_subtitle",
  "care_mobile_payment_information": "payment_information",
  "care_mobile_delete_account": "delete_account"
};
