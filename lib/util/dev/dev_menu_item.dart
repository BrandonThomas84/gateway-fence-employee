import 'package:flutter/material.dart';

class DevMenuItem extends StatelessWidget {
  const DevMenuItem({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String buttonText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
