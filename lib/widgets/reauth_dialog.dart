import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:gateway_fence_employee/providers/current_route_provider.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/widgets/password_input.dart';
import 'package:gateway_fence_employee/widgets/snack_bar_themed.dart';

class ReauthDialog extends StatefulWidget {
  const ReauthDialog({super.key, this.onSuccess});

  final void Function()? onSuccess;

  @override
  State<ReauthDialog> createState() => _ReauthDialogState();
}

class _ReauthDialogState extends State<ReauthDialog> {
  late final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _password = '';

  @override
  void initState() {
    super.initState();
    AppLogger.trace('reauth dialog initialized');
    _formkey.currentState?.reset();
  }

  Future<String> handleReauthentication(AuthProvider? authProvider) async {
    if (!_formkey.currentState!.validate()) {
      AppLogger.trace('reauthenticate form is invalid');
      return Future<String>.value(
          'Please check your submission and try again.');
    }

    if (authProvider?.user == null) {
      AppLogger.warn(
          'no user available to reauthenticate in the auth provider');
      Provider.of<CurrentRouteProvider>(context, listen: false)
          .setCurrentRoute('/register', context);
      return Future<String>.value(
          'It apprears as though your session has ended. Please sign in again.');
    }

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: authProvider!.user?.email ?? '', password: _password)
          .then((UserCredential value) {
        widget.onSuccess?.call();
        AppLogger.trace('reauthentication successful');
      });
      return Future<String>.value('success');
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.error('firebase reauthentication error',
          error: e, stackTrace: stackTrace);
      return Future<String>.value(e.message);
    } catch (e, stackTrace) {
      AppLogger.error('unknown reauthentication error',
          error: e, stackTrace: stackTrace);
    }
    return Future<String>.value(
        'We\'re sorry but an unknown error has occurred. Please try again later');
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Dialog(
      child: Container(
        height: 350,
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(
              color: AppColors.greyLight,
              width: 1,
            ),
          ),
        ),
        child: Center(
          child: Form(
            key: _formkey,
            child: ListView(
                padding: const EdgeInsets.all(10.0),
                children: <Widget>[
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset('assets/logo_transparent.png'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Please re-enter your password to continue.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  PasswordInput(
                    onChanged: (String value) {
                      _password = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          _formkey.currentState!.reset();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          handleReauthentication(authProvider)
                              .then((String value) {
                            // if successful
                            if (value == 'success') {
                              Navigator.pop(context);
                              return;
                            }
                            SnackBarThemed(
                              context: context,
                              message: value,
                              type: SnackBarThemedType.error,
                            ).show();
                          });
                        },
                        child: const Text('Reauthenticate'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ]),
          ),
        ),
      ),
    );
  }
}
