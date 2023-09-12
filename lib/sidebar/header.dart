import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/sidebar/profile.dart';
import 'package:gateway_fence_employee/sidebar/status_timer.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(
        color: Colors.white,
      ),
      child: Container(
        color: Colors.blue,
        width: double.infinity,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Profile(),
            StatusTimer(),
          ],
        ),
      ),
    );
  }
}
