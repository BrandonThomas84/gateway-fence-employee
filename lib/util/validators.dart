// Package imports:
import 'package:form_field_validator/form_field_validator.dart';

class ConfirmPasswordValidator extends TextFieldValidator {
  final String match;

  ConfirmPasswordValidator(this.match, {required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) => (value != null && value == match);
}


class ConfirmNoMatchValidator extends TextFieldValidator {
  final String match;

  ConfirmNoMatchValidator(this.match, {required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) => (value != null && value != match);
}
