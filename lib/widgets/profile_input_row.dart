import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gateway_fence_employee/config/colors.dart';

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
  });

  final String name;
  final IconData icon;
  final String initialValue;
  final Function onSavePress;
  final MultiValidator? validator;
  final Function? onCancelPress;
  final Function? onEditPress;

  @override
  State<ProfileInputRow> createState() => _ProfileInputRowState();
}

class _ProfileInputRowState extends State<ProfileInputRow> {
  late final _formKey = GlobalKey<FormState>();
  late final _inputKey = GlobalKey<FormFieldState>();

  late String _value;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _formKey.currentState?.reset();
    _value = widget.initialValue;
  }

  void handleEditPress() {
    if (widget.onEditPress != null) {
      widget.onEditPress!();
    }
    setState(() {
      _editing = true;
    });
  }

  void handleCancelPress() {
    if (widget.onCancelPress != null) {
      widget.onCancelPress!();
    }
    setState(() {
      _editing = false;
    });
  }

  void handleSavePress() {
    if (_formKey.currentState!.validate()) {
      widget.onSavePress(_value);
      setState(() {
        _editing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double inputWidth = MediaQuery.of(context).size.width * 0.7;
    double inputWidthWhenEditing = MediaQuery.of(context).size.width * 0.9;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: _editing ? inputWidthWhenEditing : inputWidth,
                child: TextFormField(
                  key: _inputKey,
                  enabled: _editing,
                  initialValue: widget.initialValue,
                  decoration: InputDecoration(
                    hintText: widget.name,
                    labelText: widget.name,
                    prefixIcon: Icon(widget.icon, color: AppColors.blue),
                    border: const OutlineInputBorder(),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  validator: widget.validator?.call,
                  onChanged: (value) {
                    _value = value;
                  },
                ),
              ),
              if (!_editing)
                TextButton(
                  onPressed: handleEditPress,
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
                    onPressed: handleCancelPress,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: handleSavePress,
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
