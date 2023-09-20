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

  // necessary for state comparison
  // ignore: unused_field
  String _confirmPassword = '';

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
                        hintText: 'Email',
                        labelText: 'Email',
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
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.key_outlined,
                          color: AppColors.blue,
                        ),
                        border: OutlineInputBorder(),
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
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(
                          Icons.key_outlined,
                          color: AppColors.blue,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: 'Confirm Password is required'),
                        MinLengthValidator(8,
                            errorText:
                                'Password must be at least 8 digits long'),
                        PatternValidator(r'(?=.*?[#!@$%^&*-])',
                            errorText:
                                'Password must contain at least one special character'),
                        ConfirmPasswordValidator(_password,
                            errorText: 'Passwords do not match'),
                      ]).call,
                      onChanged: (value) {
                        _confirmPassword = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
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
