// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';

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
    this.keyboardType,
    this.inputFormatters,
  });

  /// The name of the input
  final String name;

  /// The icon that will be displayed on the left side of the input
  final IconData icon;

  /// The initial value of the input
  final String initialValue;

  /// The validators that will be used to validate the input
  final MultiValidator? validator;

  final TextInputType? keyboardType;

  final List<TextInputFormatter>? inputFormatters;

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

    _editing = false;

    formKey = GlobalKey<FormState>();
  }

  /// Cancel the edit
  void doCancel() {
    setState(() {
      _editing = false;
    });
  }

  ///
  void doEdit(User user) {
    setState(() {
      _editing = true;
    });
  }

  void doSave(bool shouldRun) {
    if (!shouldRun) {
      return;
    }

    setState(() {
      _editing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<AuthProvider>(context).user;
    final double inputWidth = MediaQuery.of(context).size.width * 0.7;
    final double inputWidthWhenEditing =
        MediaQuery.of(context).size.width * 0.9;

    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: _editing ? inputWidthWhenEditing : inputWidth,
                child: TextFormField(
                  inputFormatters:
                      widget.inputFormatters ?? <TextInputFormatter>[],
                  keyboardType: widget.keyboardType ?? TextInputType.text,
                  validator: widget.validator?.call,
                  enabled: _editing,
                  initialValue: widget.initialValue,
                  onChanged: (String value) {
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
                          .then((bool value) => doEdit(user!));
                    } else {
                      doEdit(user!);
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
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      formKey.currentState!.reset();
                      if (widget.onCancelPress != null) {
                        widget.onCancelPress!()
                            .then((void value) => doCancel());
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
                            .then((bool value) => doSave(value));
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
