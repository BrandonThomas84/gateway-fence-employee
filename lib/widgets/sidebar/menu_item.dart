import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isActive;

  const MenuItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 30,
          ),
          child: Icon(
            icon,
            size: 30,
            color: isActive ? AppColors.blue : AppColors.black,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: isActive ? AppColors.blue : AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
