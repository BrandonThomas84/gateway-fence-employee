import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/util/log.dart';

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
  final Future<bool> Function(String? value) onSavePress;
  final Future<void> Function()? onCancelPress;
  final Future<bool> Function()? onEditPress;
  final MultiValidator? validator;

  @override
  State<ProfileInputRow> createState() => _ProfileInputRowState();
}

class _ProfileInputRowState extends State<ProfileInputRow> {
  // whether or not the user is editing the input
  bool _editing = false;

  // the value of the input
  String _value = '';

  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    
    Logger.info('profile input row init state is running', data: {
      'initialValue': widget.initialValue,
      'currentValue': _value,  
      'editing': _editing,
    });
  }

  void doCancel() {
    setState(() {
      _editing = false;
    });
    
    Logger.info('canceling profile input row edit', data: {
      'currentValue': _value,  
      'editing': _editing,
    });
  }

  void doEdit(bool shouldRun) {
    if (!shouldRun) {
      return;
    }

    setState(() {
      _editing = true;
    });
    
    Logger.info('editng profile input row', data: {
      'currentValue': _value,  
      'editing': _editing,
    });
  }

  void doSave(bool shouldRun) {
    if (!shouldRun) {
      return;
    }
    
    setState(() {
      _editing = false;
    });
    
    Logger.info('saving profile input row edit', data: {
      'currentValue': _value,  
      'editing': _editing,
    });
  }




  @override
  Widget build(BuildContext context) {
    double inputWidth = MediaQuery.of(context).size.width * 0.7;
    double inputWidthWhenEditing = MediaQuery.of(context).size.width * 0.9;

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
                      await widget.onEditPress!().then((value) => doEdit(value));
                    } else {
                      doEdit(true);
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
                        widget.onSavePress(_value).then((value) => doSave(value));
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
