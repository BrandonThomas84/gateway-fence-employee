// Package imports:
import 'package:form_field_validator/form_field_validator.dart';

class ConfirmPasswordValidator extends TextFieldValidator {

  ConfirmPasswordValidator(this.match, {required String errorText}) : super(errorText);
  
  final String match;

  @override
  bool isValid(String? value) => value != null && value == match;
}


class ConfirmNoMatchValidator extends TextFieldValidator {

  ConfirmNoMatchValidator(this.match, {required String errorText}) : super(errorText);
  
  final String match;

  @override
  bool isValid(String? value) => value != null && value != match;
}
