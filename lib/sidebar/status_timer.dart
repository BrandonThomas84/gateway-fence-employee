import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';

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
        height: 80,
        child: const Row(
          children: [
            PauseButton(),
            SizedBox(width: 10),
            Column(
              children: [
                Text('CLOCK STARTED AT 12:34:45 PM'),
                SizedBox(height: 5),
                Text(
                  '01:23:45',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w200,
                    height: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
