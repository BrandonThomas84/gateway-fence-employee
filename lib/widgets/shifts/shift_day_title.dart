// Flutter imports:
import 'package:flutter/material.dart';

class ShiftDayTitle extends StatelessWidget {
  const ShiftDayTitle({
    super.key,
    required this.title,
    required this.allowEdit,
  });

  final String title;
  final bool allowEdit;

  @override
  Widget build(BuildContext context) {
    Widget iconStack = const SizedBox(height: 1);

    if (allowEdit) {
      iconStack = const Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Tooltip(
              message: 'New entry',
              child: Icon(
                Icons.add_circle_outline,
                semanticLabel: 'Add new entry',
                size: 20,
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        iconStack,
      ],
    );
  }
}
