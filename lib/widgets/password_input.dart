import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gateway_fence_employee/config/colors.dart';

/// A password input that can be used in forms
class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    Function(String password)? this.onChanged,
  });

  /// The function that will be called when the user changes the password
  final void Function(String password)? onChanged;

  String get password => _PasswordInputState().password;
  bool get passwordVisible => _PasswordInputState().passwordVisible;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  String _password = '';
  bool _passwordVisible = false;

  String get password => _password;
  bool get passwordVisible => _passwordVisible;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
          hintText: 'Password',
          labelText: 'Password',
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
      validator: MultiValidator([
        RequiredValidator(errorText: 'Password is required'),
        MinLengthValidator(8,
            errorText: 'Password must be at least 8 digits long'),
        PatternValidator(r'(?=.*?[#!@$%^&*-])',
            errorText: 'Password must contain at least one special character')
      ]).call,
      onChanged: (value) {
        _password = value;
        widget.onChanged?.call(_password);
      },
    );
  }
}
