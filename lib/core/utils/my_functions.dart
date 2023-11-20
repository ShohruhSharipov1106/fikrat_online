import 'package:fikrat_online/core/data/singletons/storage.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class MyFunctions {
  static String formatForMask({
    required String text,
    required String maskedFormat,
    String regExpFormat = r'^[0-9*]',
  }) {
    return MaskTextInputFormatter(mask: maskedFormat, initialText: text, filter: {
      "#": RegExp(regExpFormat),
    }).getMaskedText();
  }

  static String getErrorMessage({required dynamic response}) {
    String errorMessage = '';
    if (response is Map && (response).values.isNotEmpty) {
      if ((response).values.last is Map) {
        if ((response).containsKey("detail")) {
          if (response["detail"] is Map) {
            if ((response["detail"] as Map).containsKey("message")) {
              if (response["detail"]["message"] is Map) {
                errorMessage = response["detail"]["message"][StorageRepository.getString(StoreKeys.language)];
              }
            }
          }
        }
      } else if ((response).values.last is List) {
        if (((response).values.last as List).isNotEmpty) {
          if (((response).values.last as List).last is Map) {
            errorMessage = (((response).values.last as List).last as Map).values.last.toString();
          } else if (((response).values.last as List).last is String) {
            errorMessage = ((response).values.last as List).last;
          }
        }
      } else {
        errorMessage = response.values.last.toString();
      }
    } else {
      errorMessage = 'Unknown error';
    }
    return errorMessage;
  }

  static String formatHour(String time, {String? format = 'HH:mm'}) => Jiffy.parse(time).format(pattern: format);


  static String getFormatCostFromInt(String priceString, [bool showCurrency = true]) {
    int price = priceString.isEmpty || priceString == "-1" ? 0 : int.parse(priceString.split('.')[0]);
    if (price == 0) {
      return '0 ${showCurrency ? ' UZS' : ''}';
    } else {
      final oldCost = StringBuffer(price.toString());
      final newCost = StringBuffer();

      for (var i = 0; i < oldCost.length; i++) {
        if ((oldCost.length - i) % 3 == 0 && i != 0) newCost.write(' ');
        newCost.write(oldCost.toString()[i]);
      }
      return '$newCost${showCurrency ? ' UZS' : ''}';
    }
  }
  static String formatNumber(int number) {
    if (number >= 1000000) {
      final millions = (number / 1000000).toStringAsFixed(0);
      return '${millions}M';
    } else if (number >= 1000) {
      final thousands = (number / 1000).toStringAsFixed(0);
      return '${thousands}K';
    } else {
      return number.toString();
    }
  }
}
