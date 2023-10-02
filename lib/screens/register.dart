// Flutter imports:
// import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/current_route_provider.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/util/validators.dart';
import 'package:gateway_fence_employee/widgets/password_input.dart';
import 'package:gateway_fence_employee/widgets/snack_bar_themed.dart';
import 'default_screen_scaffold.dart';

GoRoute registerScreenGoRoute = GoRoute(
  path: '/register',
  builder: (BuildContext context, GoRouterState state) =>
      const RegisterScreen(),
);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _doingRegister = false;

  // necessary for state comparison
  // ignore: unused_field
  String _confirmPassword = '';

  @override
  void initState() {
    super.initState();
    _formkey.currentState?.reset();
  }

  Future<String> handleRegister() async {
    setState(() {
      _doingRegister = true;
    });

    try {
      // ignore: unused_local_variable
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);

      // create the firebase database user record
      if (credential.user == null){
        throw Exception('no credential user found');
      }

      // create a new key for the user
      final String? userKey = FirebaseDatabase.instance.ref('users').push().key;
      if (userKey == null) {
        throw Exception('failed to push for new user key');
      }
      FirebaseDatabase.instance.ref('users/$userKey').set(
        <String, dynamic>{
          'uid': credential.user!.uid,
          'email': credential.user!.email,
          'verified': credential.user!.emailVerified,
          'phone': credential.user!.phoneNumber,
          'created': DateTime.now().millisecondsSinceEpoch.toString(),
        },
      // ignore: always_specify_types
      ).then((value) {
        AppLogger.info('successfully created the user record: users/$userKey');
      // ignore: always_specify_types
      }).catchError((err) {
        AppLogger.error('failed to write user recod to DB, message: $err');

        throw Exception(err);
      });

      setState(() {
        _doingRegister = false;
      });

      return Future<String>.value('success');
    } on FirebaseAuthException catch (e) {
      AppLogger.error('firebase registration error: ${e.toString()}',
          data: <String, String>{
            'code': e.code,
            'message': e.message ?? '',
            'error': e.toString(),
          });

      setState(() {
        _doingRegister = false;
      });

      return Future<String>.value(e.message);
    } catch (e) {
      AppLogger.error('unknown registration error: ${e.toString()}');

      setState(() {
        _doingRegister = false;
      });

      return Future<String>.value(
          'We\'re sorry but an unknown error has occurred. Please try again later');
    }
  }

  void redirectToLogin() {
    Provider.of<CurrentRouteProvider>(context, listen: false)
        .setCurrentRoute('/login', context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreenScaffold(
      title: 'Register',
      scaffoldKey: GlobalKey<ScaffoldState>(),
      children: <Widget>[
        Column(
          children: <Widget>[
            Form(
              key: _formkey,
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(35),
                  child: Image.asset(
                    'assets/logo_transparent.png',
                    width: 200,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.blue,
                    ),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w800),
                  ),
                  validator: MultiValidator(<FieldValidator<dynamic>>[
                    RequiredValidator(errorText: 'Email is required'),
                    EmailValidator(errorText: 'Enter a valid email address'),
                  ]).call,
                  onChanged: (String value) {
                    _email = value;
                  },
                ),
                const SizedBox(height: 20),
                PasswordInput(
                  onChanged: (String value) {
                    _password = value;
                  },
                ),
                const SizedBox(height: 20),
                PasswordInput(
                  extraValidators: <FieldValidator<dynamic>>[
                    ConfirmPasswordValidator(_password,
                        errorText: 'Passwords do not match')
                  ],
                  onChanged: (String value) {
                    _confirmPassword = value;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.blue),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15)),
                  ),
                  onPressed: () {
                    if (_doingRegister) {
                      return;
                    }

                    if (_formkey.currentState!.validate()) {
                      handleRegister().then((String str) {
                        final bool isSuccess = str == 'success';

                        final SnackBarThemedType type = isSuccess
                            ? SnackBarThemedType.success
                            : SnackBarThemedType.error;

                        SnackBarThemed(
                          context: context,
                          message: isSuccess
                              ? 'Welcome! Please sign in with your credentials'
                              : str,
                          type: type,
                        ).show(durationSeconds: isSuccess ? 3 : 8);

                        if (isSuccess) {
                          redirectToLogin();
                        }
                      });
                    }
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: redirectToLogin,
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(color: AppColors.blue),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
