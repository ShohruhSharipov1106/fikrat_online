import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Formatters {
  static MaskTextInputFormatter phoneFormatter([String? initialText]) =>
      MaskTextInputFormatter(
        mask: '## ### ## ##',
        initialText: initialText,
        filter: {'#': RegExp(r'[\+0-9]')},
        type: MaskAutoCompletionType.lazy,
      );
  static final cardNumberFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final cardExpirationDateFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  static final cvvFormatter = MaskTextInputFormatter(
    mask: '###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}
