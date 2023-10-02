// Flutter imports:
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gateway_fence_employee/models/user.dart';
import 'package:gateway_fence_employee/util/phone.dart';
import 'package:gateway_fence_employee/widgets/reauth_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Project imports:
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

  late int _emailAttempts = 0;

  final int _maxAttempts = 3;

  Future<bool> onEmailSave(String? value, AuthProvider auth) async {
    if (value == null) {
      return Future<bool>.value(false);
    }

    if (_emailAttempts > _maxAttempts) {
      AppLogger.warn('Max email attempts reached');
      return Future<bool>.value(false);
    }

    setState(() {
      _emailAttempts++;
    });
    AppLogger.trace('attempting to update email address to: $value',
        data: <String, int>{'attempts': _emailAttempts});

    try {
      auth.user?.updateEmail(value).then((void val) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Successfully updated your email address')));
      });
      return Future<bool>.value(true);
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.error('Firebase auth error', error: e, stackTrace: stackTrace);

      return Future<bool>.value(false);
    } on FirebaseException catch (e, stackTrace) {
      if (e.code != '') {
        AppLogger.error('Firebase error while updating email address',
            error: e, stackTrace: stackTrace);
        return Future<bool>.value(false);
      }

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ReauthDialog(
            onSuccess: () {
              onEmailSave(value, auth);
            },
          );
        },
      );
    } catch (e) {
      AppLogger.error('unknown error updating email address: ${e.toString()}');

      return Future<bool>.value(false);
    }
    return Future<bool>.value(false);
  }

  Future<bool> onNameSave(String? value, AuthProvider auth) async {
    AppLogger.trace('attempting to update display name to: $value');
    if (value == null) {
      AppLogger.warn('value was null');
      return Future<bool>.value(false);
    }

    try {
      auth.user?.updateDisplayName(value).then((void val) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Successfully updated your display name')));
      });
      return Future<bool>.value(true);
    } on FirebaseAuthException catch (e) {
      AppLogger.error('Firebase auth error: ${e.toString()}');
      return Future<bool>.value(false);
    } on FirebaseException catch (e) {
      AppLogger.error(
          'Firebase error while updating displayName: ${e.toString()}');
      return Future<bool>.value(false);
    } catch (e) {
      AppLogger.error('unknown error updating displayName: ${e.toString()}');

      return Future<bool>.value(false);
    }
  }

  Future<bool> onPhoneSave(String? value, AuthProvider auth) async {
    AppLogger.trace('attempting to update phone number to: $value');
    if (value == null) {
      AppLogger.warn('value was null');
      return Future<bool>.value(false);
    }

    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('users/${auth.user?.uid}');

    final UserModel userModel = UserModel(
      auth.user!.uid,
      email: auth.user?.email,
      displayName: auth.user?.displayName,
      phone: value,
    );

    await ref.set(userModel.toJson());

    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return DefaultScreenScaffold(
      title: 'Profile',
      subtitle: 'You can update your profile information here',
      scaffoldKey: GlobalKey<ScaffoldState>(),
      children: <Widget>[
        ProfileInputRow(
          name: emailInputName,
          icon: Icons.email_outlined,
          initialValue: authProvider.user?.email ?? '',
          validator: MultiValidator(<FieldValidator<dynamic>>[
            RequiredValidator(errorText: 'Email is required'),
            EmailValidator(errorText: 'Must be a valid email address'),
            ConfirmNoMatchValidator(authProvider.user?.email ?? '',
                errorText: 'Email cannot be the same as before')
          ]),
          onSavePress: (String? value) {
            return onEmailSave(value, authProvider);
          },
        ),
        ProfileInputRow(
          name: 'Name',
          icon: Icons.person_2_outlined,
          initialValue: authProvider.user?.displayName ?? '',
          onSavePress: (String? value) {
            return onNameSave(value, authProvider);
          },
        ),
        ProfileInputRow(
          name: 'Phone Number',
          icon: Icons.phone_android_outlined,
          initialValue: authProvider.userModel?.phone ?? '',
          inputFormatters: <TextInputFormatter>[PhoneNumberFormatter()],
          keyboardType: TextInputType.phone,
          onSavePress: (String? value) {
            return onPhoneSave(value, authProvider);
          },
        ),
      ],
    );
  }
}
