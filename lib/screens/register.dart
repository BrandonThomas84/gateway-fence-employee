import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/current_route_provider.dart';
import 'package:gateway_fence_employee/screens/_helper.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/util/validators.dart';
import 'package:gateway_fence_employee/widgets/password_input.dart';
import 'package:gateway_fence_employee/widgets/snack_bar_themed.dart';
import 'package:go_router/go_router.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

GoRoute registerScreenGoRoute = GoRoute(
  path: '/register',
  builder: (context, state) => const RegisterScreen(),
);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final _formkey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  // necessary for state comparison
  // ignore: unused_field
  String _confirmPassword = '';

  @override
  void initState() {
    super.initState();
    _formkey.currentState?.reset();
  }

  Future<String> handleRegister() async {
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      return Future<String>.value('success');
    } on FirebaseAuthException catch (e) {
      Logger.error('firebase registration error: ${e.toString()}', data: {
        'code': e.code,
        'message': e.message ?? '',
        'error': e.toString(),
      });
      return Future<String>.value(e.message);
    } catch (e) {
      Logger.error('unknown registration error: ${e.toString()}');
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
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Column(
              children: [
                Form(
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
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Email is required'),
                        EmailValidator(
                            errorText: 'Enter a valid email address'),
                      ]).call,
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    PasswordInput(
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    PasswordInput(
                      extraValidators: [
                        ConfirmPasswordValidator(_password,
                            errorText: 'Passwords do not match')
                      ],
                      onChanged: (value) {
                        _confirmPassword = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.blue),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15)),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          handleRegister().then((str) {
                            bool isSuccess = str == 'success';

                            SnackBarThemedType type = isSuccess
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
          ),
        ),
      ],
    );
  }
}
