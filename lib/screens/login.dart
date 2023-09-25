// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/current_route_provider.dart';
import 'package:gateway_fence_employee/util/auth.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/widgets/password_input.dart';
import 'package:gateway_fence_employee/widgets/snack_bar_themed.dart';
import 'default_screen_scaffold.dart';

GoRoute loginScreenGoRoute = GoRoute(
  path: '/login',
  builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  late final SnackBarThemed unknownUser;

  @override
  void initState() {
    super.initState();
    _formkey.currentState?.reset();
  }

  /// Handles the login button press
  /// Will return a string if there is an error or `success` if the login was successful
  Future<String> handleLoginPress(BuildContext context) async {
    if (!_formkey.currentState!.validate()) {
      return Future<String>.value('internal-invalid-form');
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);

      return Future<String>.value('success');
    } on FirebaseAuthException catch (e) {
      Logger.error('firebase login error', data: <String, String>{
        'code': e.code,
        'message': e.message ?? '',
        'error': e.toString(),
      });

      return Future<String>.value(e.code);
    } catch (e) {
      Logger.error('unknown login error', data: <String, String>{
        'error': e.toString(),
      });

      return Future<String>.value('unknown');
    }
  }

  void redirectToHome() {
    Provider.of<CurrentRouteProvider>(context, listen: false)
        .setCurrentRoute('/', context);
  }

  void handleRegisterPress() {
    Provider.of<CurrentRouteProvider>(context, listen: false)
        .setCurrentRoute('/register', context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreenScaffold(
      title: 'Login',
      scaffoldKey: GlobalKey<ScaffoldState>(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Form(
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
                    hintText: 'Email',
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.blue,
                    ),
                    border: OutlineInputBorder(),
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
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.blue),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15)),
                  ),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      handleLoginPress(context).then((String value) {
                        // if successful
                        if (value == 'success') {
                          SnackBarThemed(
                            context: context,
                            message: 'Welcome back!',
                            type: SnackBarThemedType.success,
                          ).show();
                          redirectToHome();
                          return;
                        }

                        if (value != 'internal-invalid-form') {
                          SnackBarThemed(
                            context: context,
                            message:
                                getFirebaseAuthenticationErrorMessageFromCode(
                                    value),
                            type: SnackBarThemedType.error,
                          ).show(durationSeconds: 7);
                        }
                      });
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: handleRegisterPress,
                  child: const Text(
                    'Don\'t have an account? Register here',
                    style: TextStyle(color: AppColors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: handleLoginPress,
                //   child: const Text('Login'),
                // ),
                // ElevatedButton(
                //   onPressed: handleRegisterPress,
                //   child: const Text('Register'),
                // ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
