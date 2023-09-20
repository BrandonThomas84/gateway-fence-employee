import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/current_route_provider.dart';
import 'package:gateway_fence_employee/screens/_helper.dart';
import 'package:gateway_fence_employee/util/log.dart';
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

  @override
  void initState() {
    super.initState();
    _formkey.currentState?.reset();
  }

  Future<void> handleLoginPress() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((value) => redirectToHome());
    } catch (e) {
      Logger.error('error logging in: ${e.toString()}');
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
                    errorStyle: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w800),
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
                  onPressed: handleLoginPress,
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: handleRegisterPress,
                  child: const Text('Register'),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
