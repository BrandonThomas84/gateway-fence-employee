import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/current_route_provider.dart';
import 'package:gateway_fence_employee/screens/_helper.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/widgets/snack_bar_themed.dart';
import 'package:go_router/go_router.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

GoRoute loginScreenGoRoute = GoRoute(
  path: '/login',
  builder: (context, state) => const LoginScreen(),
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final _formkey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _formkey.currentState?.reset();
  }

  Future<void> handleLoginPress(context) async {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((value) => redirectToHome());
    } on FirebaseAuthException catch (e) {
      Logger.error('FirebaseAuthException while logging in: ${e.toString()}');

      e.code == 'user-not-found'
          ? SnackBarThemed(
              type: SnackBarThemedType.error,
              message:
                  'No user found for that email. Please check the email address entered and try again',
              context: context,
            ).show()
          : e.code == 'wrong-password'
              ? SnackBarThemed(
                  type: SnackBarThemedType.error,
                  message: 'Wrong password provided for that user.',
                  context: context,
                ).show()
              : SnackBarThemed(
                  type: SnackBarThemedType.error,
                  message: 'An error occurred while logging in.',
                  context: context,
                ).show();
    } catch (e) {
      Logger.error('unknown error while trying to sign in: ${e.toString()}');

      SnackBarThemed(
        type: SnackBarThemedType.error,
        message: 'We\'re sorry but an unknown error occurred while attmepting to log you in. Please try again later.',
        context: context,
      ).show();
    }
  }

  void redirectToHome() {
    Provider.of<CurrentRouteProvider>(context, listen: false)
        .setCurrentRoute('/', context);
    SnackBarThemed(
        type: SnackBarThemedType.success,
        message: 'Welcome back!',
        context: context,
      ).show();
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
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Form(
              key: _formkey,
              child: Column(children: [
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
                        const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15)),
                  ),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      handleLoginPress(context);
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
