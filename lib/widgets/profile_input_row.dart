import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:gateway_fence_employee/providers/current_route_provider.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:provider/provider.dart';

class ProfileInputRow extends StatefulWidget {
  const ProfileInputRow({
    super.key,
    required this.name,
    required this.icon,
    required this.initialValue,
    required this.onSavePress,
    this.onCancelPress,
    this.onEditPress,
    this.validator,
    this.isSecure = false,
    this.startEditing = false,
  });

  /// The name of the input
  final String name;

  /// The icon that will be displayed on the left side of the input
  final IconData icon;

  /// The initial value of the input
  final String initialValue;

  /// The validators that will be used to validate the input
  final MultiValidator? validator;

  /// Whether or not the input is secure, if this is marked as true the user
  /// will be asked to reauthenticate before editing the input
  final bool isSecure;

  final bool startEditing;

  /// The function that will be called when the user presses save, it should
  /// return a `Future<bool>` that will determine whether or not the input
  /// should be saved
  final Future<bool> Function(String? value) onSavePress;

  /// The *OPTIONAL* function that will be called when the user presses cancel
  final Future<void> Function()? onCancelPress;

  /// The *OPTIONAL* function that will be called when the user presses edit
  /// it should return a `Future<bool>` that will determine whether or not the
  /// input should be editable
  final Future<bool> Function()? onEditPress;

  @override
  State<ProfileInputRow> createState() => _ProfileInputRowState();
}

class _ProfileInputRowState extends State<ProfileInputRow> {
  /// whether or not the user is currently editing the input
  late bool _editing;

  /// the value of the input
  String _value = '';

  /// The form key that will be used to validate the input
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();

    _editing = widget.startEditing;

    formKey = GlobalKey<FormState>();

    Logger.info('profile input row init state is running', data: {
      'initialValue': widget.initialValue,
      'currentValue': _value,
      'requiresReAuth': widget.isSecure &&
          Provider.of<AuthProvider>(context, listen: false)
              .shouldReauthenticate(),
      'secure': widget.isSecure,
      'editing': _editing,
      'lastrefreshed': Provider.of<AuthProvider>(context, listen: false)
          .lastRefreshed
          .toString(),
    });
  }

  /// Cancel the edit
  void doCancel() {
    Logger.info('cancelling edit input row', data: {
      'currentValue': _value,
      'editing': _editing,
    });
    setState(() {
      _editing = false;
    });
  }

  ///
  void doEdit(
    User user,
    bool shouldReauth,
    DateTime? lastAuth,
  ) {
    Logger.info('attempting edit input row', data: {
      'currentValue': _value,
      'editing': _editing,
      'secure': widget.isSecure,
      'shouldReauth': shouldReauth,
      'lastAuth': lastAuth.toString(),
    });
    if (widget.isSecure && shouldReauth) {
      Provider.of<CurrentRouteProvider>(context, listen: false)
          .setCurrentRoute('/reauth', context);
    } else {
      setState(() {
        _editing = true;
      });
    }
  }

  void doSave(bool shouldRun) {
    if (!shouldRun) {
      return;
    }

    setState(() {
      _editing = false;
    });

    Logger.info('saving input row', data: {
      'currentValue': _value,
      'editing': _editing,
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthProvider>(context).user;
    double inputWidth = MediaQuery.of(context).size.width * 0.7;
    double inputWidthWhenEditing = MediaQuery.of(context).size.width * 0.9;
    DateTime? lastAuth = Provider.of<AuthProvider>(context).lastRefreshed;
    bool shouldReauth = Provider.of<AuthProvider>(context).shouldReauthenticate();

    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: _editing ? inputWidthWhenEditing : inputWidth,
                child: TextFormField(
                  validator: widget.validator?.call,
                  enabled: _editing,
                  initialValue: widget.initialValue,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: widget.name,
                    labelText: widget.name,
                    prefixIcon: Icon(widget.icon, color: AppColors.blue),
                    border: const OutlineInputBorder(),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              if (!_editing)
                TextButton(
                  onPressed: () async {
                    if (widget.onEditPress != null) {
                      await widget.onEditPress!()
                          .then((value) => doEdit(user!, shouldReauth, lastAuth));
                    } else {
                      doEdit(user!, shouldReauth, lastAuth);
                    }
                  },
                  child: const Text('Edit'),
                ),
            ],
          ),
          if (_editing)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      formKey.currentState!.reset();
                      if (widget.onCancelPress != null) {
                        widget.onCancelPress!().then((value) => doCancel());
                      } else {
                        doCancel();
                      }
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        widget
                            .onSavePress(_value)
                            .then((value) => doSave(value));
                      }
                    },
                    child: const Text('Save'),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
