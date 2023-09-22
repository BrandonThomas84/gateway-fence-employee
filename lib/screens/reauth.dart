import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/widgets/password_input.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '_helper.dart';

GoRoute reauthScreenGoRoute = GoRoute(
  path: '/reauth',
  builder: (context, state) => const ReauthScreen(),
);

class ReauthScreen extends StatefulWidget {
  const ReauthScreen({
    super.key,
  });

  @override
  State<ReauthScreen> createState() => _ReauthScreenState();
}

class _ReauthScreenState extends State<ReauthScreen> {
  late final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _password = '';

  @override
  void initState() {
    super.initState();
    _formkey.currentState?.reset();
  }

  Future<void> handleReauthentication(AuthProvider? authProvider) async {
    if (!_formkey.currentState!.validate()) {
      Logger.info('reauthenticate form is invalid');
      return Future.value();
    }

    if (authProvider?.user == null) {
      Logger.warn('no user available to reauthenticate in the auth provider');
      return Future.value();
    }

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: authProvider!.user?.email ?? '',
        password: _password,
      )
          .then((value) {
        Logger.info('reauthentication successful');
        authProvider.markRefreshed();
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      Logger.error('firebase reauthentication error', data: {
        'code': e.code,
        'message': e.message ?? '',
        'error': e.toString(),
      });
    } catch (e) {
      Logger.error('unknown reauthentication error', data: {
        'error': e.toString(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return DefaultScreenScaffold(
      title: 'Reauthenticate',
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
                // TextFormField(
                //   obscureText: !_passwordVisible,
                //   decoration: InputDecoration(
                //       hintText: 'Password',
                //       labelText: 'Password',
                //       prefixIcon: const Icon(
                //         Icons.key_outlined,
                //         color: AppColors.blue,
                //       ),
                //       border: const OutlineInputBorder(),
                //       suffixIcon: IconButton(
                //         icon: Icon(
                //           _passwordVisible
                //               ? Icons.visibility
                //               : Icons.visibility_off,
                //           color: AppColors.blue,
                //         ),
                //         onPressed: () {
                //           setState(() {
                //             _passwordVisible = !_passwordVisible;
                //           });
                //         },
                //       )),
                //   validator: MultiValidator([
                //     RequiredValidator(errorText: 'Password is required'),
                //     MinLengthValidator(8,
                //         errorText: 'Password must be at least 8 digits long'),
                //     PatternValidator(r'(?=.*?[#!@$%^&*-])',
                //         errorText:
                //             'Password must contain at least one special character')
                //   ]).call,
                //   onChanged: (value) {
                //     _password = value;
                //   },
                // ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.blue),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15)),
                  ),
                  onPressed: () {
                    handleReauthentication(authProvider);
                  },
                  child: const Text('Reauthenticate'),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
