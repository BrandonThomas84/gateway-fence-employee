import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/util/log.dart';

class CustomAppBarItem extends StatelessWidget {
  final String tooltipMessage;
  final Widget icon;
  final double width;
  final VoidCallback? onTap;
  final bool isLast;

  const CustomAppBarItem({
    super.key,
    required this.tooltipMessage,
    required this.icon,
    required this.width,
    this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

    return Tooltip(
      message: tooltipMessage,
      key: tooltipkey,
      child: TextButton(
        onPressed: () {
          // Add your button press logic here
          Logger.info("CustomAppBar button press", data: {'tooltipMessage': tooltipMessage});
          onTap!();
        },
        child: icon,
      ),
    );
  }
}
