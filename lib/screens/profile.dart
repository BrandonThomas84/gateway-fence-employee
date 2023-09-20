import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:gateway_fence_employee/screens/_helper.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/util/validators.dart';
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
  late final _nameFormKey = GlobalKey<FormState>();
  late final _emailFormKey = GlobalKey<FormState>();
  late final _passwordFormKey = GlobalKey<FormState>();
  late final _phoneformKey = GlobalKey<FormState>();

  String _email = '';
  bool _editingEmail = false;

  String _name = '';
  bool _editingName = false;

  String _password = '';
  bool _editingPassword = false;

  String _phone = '';
  bool _editingPhone = false;

  void handleEmailUpdate(User user) {
    user.updateEmail(_email).onError((error, stackTrace) {
      Logger.error('error updating email address: ${error.toString()}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully updated your email address')));
    }).whenComplete(() => setState(() {
          _editingEmail = false;
        }));
  }

  void handleNameUpdate(User user) {
    user.updateDisplayName(_name).onError((error, stackTrace) {
      Logger.error('error updating display name: ${error.toString()}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully updated your name')));
    }).whenComplete(() => setState(() {
          _editingName = false;
        }));
  }

  void handlePhoneUpdate(User user) {
    user.updateDisplayName(_phone).onError((error, stackTrace) {
      Logger.error('error updating phone: ${error.toString()}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully updated your phone number')));
    }).whenComplete(() => setState(() {
          _editingPhone = false;
        }));
  }

  void handlePasswordUpdate(User user) {
    user.updateDisplayName(_password).onError((error, stackTrace) {
      Logger.error('error updating phone: ${error.toString()}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully updated your phone number')));
    }).whenComplete(() => setState(() {
          _editingPassword = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthProvider>(context).user;

    return DefaultScreenScaffold(
      title: 'Profile',
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
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Form(
                    key: _nameFormKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextFormField(
                            enabled: _editingName,
                            initialValue: user?.displayName ?? '',
                            decoration: const InputDecoration(
                              hintText: 'Name',
                              labelText: 'Name',
                              prefixIcon: Icon(
                                Icons.person_2_outlined,
                                color: AppColors.blue,
                              ),
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Name is required'),
                            ]).call,
                            onChanged: (value) {
                              _name = value;
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (!_editingName) {
                              setState(() {
                                _editingName = true;
                              });
                              return;
                            }

                            if (_nameFormKey.currentState!.validate()) {
                              handleNameUpdate(user!);
                            }
                          },
                          child: Text(_editingName ? 'Save' : 'Edit'),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: _emailFormKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextFormField(
                            enabled: _editingEmail,
                            initialValue: user?.email ?? '',
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              labelText: 'Email',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: AppColors.blue,
                              ),
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Email is required'),
                              EmailValidator(
                                  errorText: 'Must be a valid email address'),
                              ConfirmNoMatchValidator(user?.email ?? '',
                                  errorText:
                                      'Email cannot be the same as before')
                            ]).call,
                            onChanged: (value) {
                              _email = value;
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_editingEmail) {
                              if (_emailFormKey.currentState!.validate()) {
                                handleEmailUpdate(user!);
                              }
                            } else {
                              _editingEmail = !_editingEmail;
                            }
                          },
                          child: Text(_editingEmail ? 'Save' : 'Edit'),
                        )
                      ],
                    ),
                  ),
                ],
              )

              // Form(
              //   key: _formkey,
              //   child: Column(
              //     children: [
              //       const SizedBox(height: 20),
              //       TextFormField(
              //         initialValue: user?.email ?? '',
              //         decoration: const InputDecoration(
              //           hintText: 'Email',
              //           labelText: 'Email',
              //           prefixIcon: Icon(
              //             Icons.email_outlined,
              //             color: AppColors.blue,
              //           ),
              //           border: OutlineInputBorder(),
              //           errorStyle: TextStyle(
              //             color: Colors.red,
              //           ),
              //         ),
              //         validator: MultiValidator([
              //           RequiredValidator(errorText: 'Email is required'),
              //           EmailValidator(errorText: 'Enter a valid email address'),
              //           ConfirmNoMatchValidator(user?.email ?? '',
              //               errorText: 'Email cannot be the same as before')
              //         ]).call,
              //         onChanged: (value) {
              //           _email = value;
              //         },
              //       ),
              //       const SizedBox(height: 20),
              //       ElevatedButton(
              //         onPressed: () {
              //           if (_formkey.currentState!.validate()) {
              //             handleProfileUpdate(user!);
              //           }
              //         },
              //         child: const Text('Save Profile'),
              //       ),
              //     ],
              //   ),
              // ),
              ),
        ),
      ],
    );
  }
}
