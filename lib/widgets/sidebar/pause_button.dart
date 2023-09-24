// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: AppColors.blueLight,
      ),
      child: const Icon(
        Icons.pause,
        size: 40,
        color: AppColors.white,
      ),
    );
  }
}
