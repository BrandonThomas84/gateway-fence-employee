import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:gateway_fence_employee/screens/default_screen_scaffold.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/util/validators.dart';
import 'package:gateway_fence_employee/widgets/profile_input_row.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRoute profileScreenGoRoute = GoRoute(
  path: '/profile',
  builder: (context, state) => const ProfileScreen(),
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
      return Future.value(false);
    }

    Logger.info('attempting to update email address to: $value');

    try {
      user.updateEmail(value).then((val) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Successfully updated your email address')));
      });

      // kill the reauth request
      Provider.of<AuthProvider>(context).removeReauth(emailInputName);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      // this should only happen if the user's refresh token is too old
      // which the re-authentication should take care of
      Logger.error('Firebase auth error: ${e.toString()}');

      return Future.value(false);
    } on FirebaseException catch (e) {
      Logger.error(
          'Firebase error while updating email address: ${e.toString()}');
      return Future.value(false);
    } catch (e) {
      Logger.error('unknown error updating email address: ${e.toString()}');

      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthProvider>(context).user;
    ReauthRequest reauth =
        Provider.of<AuthProvider>(context).getReauth(emailInputName);

    return DefaultScreenScaffold(
      title: 'Profile',
      subtitle: 'You can update your profile information here',
      scaffoldKey: GlobalKey<ScaffoldState>(),
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                ProfileInputRow(
                  isSecure: !reauth.isValid(),
                  startEditing: reauth.isValid(),
                  name: emailInputName,
                  icon: Icons.email_outlined,
                  initialValue: user?.email ?? '',
                  validator: MultiValidator([
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
