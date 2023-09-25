// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/util/validators.dart';
import 'package:gateway_fence_employee/widgets/profile_input_row.dart';
import 'default_screen_scaffold.dart';

GoRoute profileScreenGoRoute = GoRoute(
  path: '/profile',
  builder: (BuildContext context, GoRouterState state) => const ProfileScreen(),
);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String emailInputName = 'Email';

  Future<bool> onEmailSave(User user, String? value) async {
    if (value == null) {
      return Future<bool>.value(false);
    }

    Logger.info('attempting to update email address to: $value');

    try {
      user.updateEmail(value).then((void val) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Successfully updated your email address')));
      });
      return Future<bool>.value(true);
    } on FirebaseAuthException catch (e) {
      // this should only happen if the user's refresh token is too old
      // which the re-authentication should take care of
      Logger.error('Firebase auth error: ${e.toString()}');

      return Future<bool>.value(false);
    } on FirebaseException catch (e) {
//       showDialog(
//   context: context,
//   builder: (BuildContext context) {
//     return ReauthDialog();
//   },
// );
      Logger.error(
          'Firebase error while updating email address: ${e.toString()}');
      return Future<bool>.value(false);
    } catch (e) {
      Logger.error('unknown error updating email address: ${e.toString()}');

      return Future<bool>.value(false);
    }
  }

  Future<bool> onNameSave(User user, String? value) async {
    if (value == null) {
      return Future<bool>.value(false);
    }

    Logger.info('attempting to update display name to: $value');

    try {
      user.updateDisplayName(value).then((void val) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Successfully updated your display name')));
      });
      return Future<bool>.value(true);
    } on FirebaseAuthException catch (e) {
      // this should only happen if the user's refresh token is too old
      // which the re-authentication should take care of
      Logger.error('Firebase auth error: ${e.toString()}');

      return Future<bool>.value(false);
    } on FirebaseException catch (e) {
      Logger.error(
          'Firebase error while updating displayName: ${e.toString()}');
      return Future<bool>.value(false);
    } catch (e) {
      Logger.error('unknown error updating displayName: ${e.toString()}');

      return Future<bool>.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<AuthProvider>(context).user;

    return DefaultScreenScaffold(
      title: 'Profile',
      subtitle: 'You can update your profile information here',
      scaffoldKey: GlobalKey<ScaffoldState>(),
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),
                ProfileInputRow(
                  name: emailInputName,
                  icon: Icons.email_outlined,
                  initialValue: user?.email ?? '',
                  validator: MultiValidator(<FieldValidator<dynamic>>[
                    RequiredValidator(errorText: 'Email is required'),
                    EmailValidator(errorText: 'Must be a valid email address'),
                    ConfirmNoMatchValidator(user?.email ?? '',
                        errorText: 'Email cannot be the same as before')
                  ]),
                  onSavePress: (String? value) {
                    return onEmailSave(user!, value);
                  },
                  // onEditPress: () {
                  //   Logger.info('editing email');
                  //   return onEditPress(user!);
                  // },
                  // onCancelPress: () {
                  //   Logger.info('cancelling email edit');
                  // },
                ),
                const SizedBox(height: 40),
                ProfileInputRow(
                  name: 'Name',
                  icon: Icons.person_2_outlined,
                  initialValue: user!.displayName ?? '',
                  onSavePress: (String? value) {
                    return onNameSave(user, value);
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
