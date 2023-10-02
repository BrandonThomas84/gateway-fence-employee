import 'dart:math';

import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  static const int _maxChars = 15;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String formattedText = _formatPhoneNumber(newValue.text);
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatPhoneNumber(String input) {
    final RegExp regex = RegExp(r'^(\d{3})(\d{3})(\d{4})$');
    final Match? match = regex.firstMatch(input);

    if (match != null && match.groupCount <= 3) {
      final String first = match.group(1)!;
      final String second = match.group(2)!;
      final String third = match.group(3)!;

      if (second.isEmpty && first.isNotEmpty) {
        return '($first';
      } else if (third.isEmpty && second.isNotEmpty) {
        return '($first) $second';
      } else if (third.isNotEmpty) {
        return '($first) $second-$third';
      }
    }

    return input.substring(0, min(input.length, _maxChars));
  }
}
