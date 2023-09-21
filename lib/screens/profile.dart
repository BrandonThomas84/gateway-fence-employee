import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:gateway_fence_employee/screens/_helper.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/util/validators.dart';
import 'package:gateway_fence_employee/widgets/profile_input_row.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRoute profileScreenGoRoute = GoRoute(
  path: '/profile',
  builder: (context, state) => const SettingsScreen(),
);

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  void handleEmailUpdate(User user, String? value) {
    Logger.info('updating email address to: $value');
    if (value == null) {
      Logger.info('email address is null');
      return;
    }

    user.updateEmail(value).onError((error, stackTrace) {
      Logger.error('error updating email address: ${error.toString()}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }).then((val) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully updated your email address')));
    });
  }

  void handleNameUpdate(User user, String? value) {
    if (value == null) {
      return;
    }
    user.updateDisplayName(value).onError((error, stackTrace) {
      Logger.error('error updating display name: ${error.toString()}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }).then((val) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully updated your name')));
    });
  }

  void handlePhoneUpdate(User user, String? value) {
    if (value == null) {
      return;
    }
    user.updateDisplayName(value).onError((error, stackTrace) {
      Logger.error('error updating phone: ${error.toString()}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }).then((val) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully updated your phone number')));
    });
  }

  void handlePasswordUpdate(User user, String? value) {
    if (value == null) {
      return;
    }
    user.updateDisplayName(value).onError((error, stackTrace) {
      Logger.error('error updating phone: ${error.toString()}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }).then((val) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully updated your phone number')));
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthProvider>(context).user;

    return DefaultScreenScaffold(
      title: 'Profile',
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
                  name: 'Email',
                  icon: Icons.email_outlined,
                  initialValue: user?.email ?? '',
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Email is required'),
                    EmailValidator(errorText: 'Must be a valid email address'),
                    ConfirmNoMatchValidator(user?.email ?? '',
                        errorText: 'Email cannot be the same as before')
                  ]),
                  onSavePress: (String? value) {
                    handleEmailUpdate(user!, value);
                  },
                  onEditPress: () {
                    Logger.info('editing email');
                  },
                  onCancelPress: () {
                    Logger.info('cancelling email edit');
                  },
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
