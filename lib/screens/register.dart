import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/current_route_provider.dart';
import 'package:gateway_fence_employee/screens/_helper.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/util/validators.dart';
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
  bool _passwordVisible = false;

  // necessary for state comparison
  // ignore: unused_field
  String _confirmPassword = '';
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _formkey.currentState?.reset();
  }

  Future<String?> handleRegister() async {
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then(
            (value) => redirectToLogin(),
          );

      return null;
    } on FirebaseAuthException catch (e) {
      Logger.error('firebase registration error: ${e.toString()}');
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return 'Unknown error occured, please try again later.';
      }
    } catch (e) {
      Logger.error('unknown registration error: ${e.toString()}');

      return 'Unknown error occured, please try again later.';
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
                    TextFormField(
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter a secure password',
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
                        ),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Password is required'),
                        MinLengthValidator(8,
                            errorText:
                                'Password must be at least 8 digits long'),
                        PatternValidator(r'(?=.*?[#!@$%^&*-])',
                            errorText:
                                'Password must contain at least one special character')
                      ]).call,
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: !_confirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Re-enter your password',
                        prefixIcon: const Icon(
                          Icons.key_outlined,
                          color: AppColors.blue,
                        ),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: MultiValidator([
                        ConfirmPasswordValidator(_password,
                            errorText: 'Passwords do not match')
                      ]).call,
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
                          handleRegister().then((err) => {
                                if (err != null)
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(err)),
                                    )
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
