// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'header.dart';
import 'menu.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * .75,
        color: AppColors.white,
        child: Column(
          children: [
            const Header(),
            Menu(),
          ],
        ),
      ),
    );
  }
}
