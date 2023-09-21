import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/screens/logout.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/widgets/snack_bar_themed.dart';
import 'package:go_router/go_router.dart';

GoRoute reauthenticateScreenGoRoute = GoRoute(
  path: '/reauthenticate',
  builder: (context, state) => const ReauthenticateScreen(),
);

class ReauthenticateScreen extends StatefulWidget {
  final Function? onSuccess;
  final Function? onError;

  const ReauthenticateScreen({
    super.key,
    this.onSuccess,
    this.onError,
  });

  @override
  State<ReauthenticateScreen> createState() => _ReauthenticateScreenState();
}

class _ReauthenticateScreenState extends State<ReauthenticateScreen> {
  late final _formkey = GlobalKey<FormState>();
  String _password = '';
  bool _passwordVisible = false;

  void showError(BuildContext context, String message) {
    SnackBarThemed(
      context: context,
      type: SnackBarThemedType.error,
      message: 'Failed to reauthenticate',
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
              onPressed: () async {
                if (FirebaseAuth.instance.currentUser == null) {
                  Logger.error(
                      'user is not available sending to the logout screen');
                  showError(
                    context,
                    'Your session seems to have expired, please login again.',
                  );
                  GoRouter.of(context).go('/logout');
                  return;
                }

                if (!_formkey.currentState!.validate()) {
                  showError(
                      context, 'The password you have entered is invalid.');
                }

                try {
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: FirebaseAuth.instance.currentUser!.email!,
                          password: _password)
                      .onError((error, stackTrace) {
                    showError(context, 'Failed to reauthenticate');
                    return Future.value();
                  }).then((value) {
                    widget.onSuccess!();
                  });
                } catch (e) {
                  Logger.error(
                      'unknown error while reauthenticating: ${e.toString()}');
                  widget.onError!();
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
    );
  }
}
