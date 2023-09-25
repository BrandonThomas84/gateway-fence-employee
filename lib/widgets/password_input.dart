// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:form_field_validator/form_field_validator.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';

/// A password input that can be used in forms
class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    Function(String password)? this.onChanged,
    this.extraValidators,
    this.hintText,
    this.labelText,
  });

  /// The function that will be called when the user changes the password
  final void Function(String password)? onChanged;

  /// Add more validators to the field. Useful for when you want to confirm
  /// a password matches
  final List<FieldValidator<dynamic>>? extraValidators;

  final String? hintText;
  final String? labelText;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  String _password = '';
  bool _passwordVisible = false;
  List<FieldValidator<dynamic>>? _validators;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
          hintText: widget.hintText ?? 'Enter a secure password',
          labelText: widget.labelText ?? 'Password',
          prefixIcon: const Icon(
            Icons.key_outlined,
            color: AppColors.blue,
          ),
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.blue,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          )),
      validator: MultiValidator(<FieldValidator<dynamic>>[
        RequiredValidator(errorText: 'Password is required'),
        MinLengthValidator(8,
            errorText: 'Password must be at least 8 digits long'),
        PatternValidator(r'(?=.*?[#!@$%^&*-])',
            errorText: 'Password must contain at least one special character'),
        ..._validators ?? <FieldValidator<dynamic>>[],
      ]).call,
      onChanged: (String value) {
        _password = value;
        widget.onChanged?.call(_password);
      },
    );
  }
}
