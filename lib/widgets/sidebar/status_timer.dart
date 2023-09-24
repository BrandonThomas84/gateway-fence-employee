// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'pause_button.dart';
import 'timer_body.dart';

class StatusTimer extends StatelessWidget {
  const StatusTimer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: AppColors.blueDark,
        ),
        padding: const EdgeInsets.all(5),
        child: const Row(
          children: [
            PauseButton(),
            SizedBox(width: 10),
            TimerBody(),
          ],
        ),
      ),
    );
  }
}
