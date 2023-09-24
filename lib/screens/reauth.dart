// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:gateway_fence_employee/providers/current_route_provider.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/widgets/password_input.dart';
import 'package:gateway_fence_employee/widgets/snack_bar_themed.dart';
import 'default_screen_scaffold.dart';

GoRoute reauthScreenGoRoute = GoRoute(
  path: '/reauth/:changeType',
  builder: (context, state) =>
      ReauthScreen(changeType: state.pathParameters['changeType'] ?? 'INVALID'),
);

class ReauthScreen extends StatefulWidget {
  const ReauthScreen({
    super.key,
    required this.changeType,
  });

  final String changeType;

  @override
  State<ReauthScreen> createState() => _ReauthScreenState();
}

class _ReauthScreenState extends State<ReauthScreen> {
  late final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _password = '';

  @override
  void initState() {
    super.initState();
    Logger.info('reauth screen initialized',
        data: {'changeType': widget.changeType});
    _formkey.currentState?.reset();
  }

  Future<String> handleReauthentication(AuthProvider? authProvider) async {
    if (!_formkey.currentState!.validate()) {
      Logger.info('reauthenticate form is invalid');
      return Future.value('Please check your submission and try again.');
    }

    if (authProvider?.user == null) {
      Logger.warn('no user available to reauthenticate in the auth provider');
      Provider.of<CurrentRouteProvider>(context, listen: false)
          .setCurrentRoute('/register', context);
      return Future.value(
          'It apprears as though your session has ended. Please sign in again.');
    }

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: authProvider!.user?.email ?? '',
        password: _password,
      )
          .then((value) {
        Logger.info('reauthentication successful');
        authProvider.completeReauth(widget.changeType);
      });
      return Future.value('success');
    } on FirebaseAuthException catch (e) {
      Logger.error('firebase reauthentication error', data: {
        'code': e.code,
        'message': e.message ?? '',
        'error': e.toString(),
      });
      return Future.value(e.message);
    } catch (e) {
      Logger.error('unknown reauthentication error', data: {
        'error': e.toString(),
      });
    }
    return Future.value(
        'We\'re sorry but an unknown error has occurred. Please try again later');
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return DefaultScreenScaffold(
      title: 'Security Reauthentication',
      subtitle: 'Please re-enter your password to continue',
      scaffoldKey: GlobalKey<ScaffoldState>(),
      children: [
        Container(
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
              child: Column(children: [
                const SizedBox(height: 20),
                PasswordInput(
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
                    handleReauthentication(authProvider).then((value) {
                      // if successful
                      if (value == 'success') {
                        Provider.of<CurrentRouteProvider>(context,
                                listen: false)
                            .goBack(context);
                        return;
                      }
                      SnackBarThemed(
                        context: context,
                        message: value,
                        type: SnackBarThemedType.error,
                      ).show(durationSeconds: 7);
                    });
                  },
                  child: const Text('Reauthenticate'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15)),
                  ),
                  onPressed: () {
                    Provider.of<CurrentRouteProvider>(context, listen: false)
                        .goBack(context);
                  },
                  child: const Text('Cancel'),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
