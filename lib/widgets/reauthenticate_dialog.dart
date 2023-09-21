import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:go_router/go_router.dart';

class ReauthenticateDialog extends StatefulWidget {
  const ReauthenticateDialog({
    super.key,
    this.onSuccess,
    this.onError,
  });

  final Function? onSuccess;
  final Function? onError;

  @override
  State<ReauthenticateDialog> createState() => _ReauthenticateDialogState();
}

class _ReauthenticateDialogState extends State<ReauthenticateDialog> {
  late final _formkey = GlobalKey<FormState>();
  late final Function _onSuccess;
  late final Function _onError;
  String _email = '';
  String _password = '';
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _formkey.currentState?.reset();
    _onSuccess = widget.onSuccess ?? () {};
    _onError = widget.onError ?? () {};
  }

  Future<void> handleLoginPress() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((value) {
        Logger.info('reauthenticated');
        _onSuccess();
        GoRouter.of(context).pop();
      });
    } catch (e) {
      Logger.error('error reauthenticating: ${e.toString()}');
      _onError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Center(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(35),
                child: Image.asset(
                  'assets/logo_transparent.png',
                  width: 200,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: AppColors.blue,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Email is required'),
                  EmailValidator(errorText: 'Enter a valid email address'),
                ]).call,
                onChanged: (value) {
                  _email = value;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
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
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                      errorText:
                          'Password must contain at least one special character')
                ]).call,
                onChanged: (value) {
                  _password = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.blue),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    handleLoginPress();
                  }
                },
                child: const Text('Reauthenticate'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
