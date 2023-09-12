import 'package:flutter/material.dart';

class EventSectionTitle extends StatelessWidget {
  final String title;
  final bool allowEdit;

  const EventSectionTitle({
    super.key,
    required this.title,
    required this.allowEdit,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconStack = const SizedBox(height: 1);

    if (allowEdit) {
      iconStack = const Stack(
        children: [
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
      children: [
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
