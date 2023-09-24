// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:gateway_fence_employee/widgets/sidebar/profile.dart';
import 'package:gateway_fence_employee/widgets/sidebar/status_timer.dart';

class Header extends StatelessWidget {
  const Header({
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
            Profile(imageSize: 60),
            StatusTimer(),
          ],
        ),
      ),
    );
  }
}
