import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/util/log.dart';

class CustomAppBarItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final double width;
  final VoidCallback? onTap;
  final bool isLast;
  final Color color;

  const CustomAppBarItem({
    super.key,
    required this.text,
    required this.icon,
    required this.width,
    this.onTap,
    this.isLast = false,
    this.color = AppColors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

    return Tooltip(
      message: text,
      key: tooltipkey,
      child: TextButton(
        onPressed: () {
          // Add your button press logic here
          Logger.info("CustomAppBar button press", data: {'text': text});
          onTap!();
        },
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
