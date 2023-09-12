import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';

import 'menu.dart';
import 'header.dart';

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
        child: const Column(
          children: [
            AppHeader(),
            AppMenu(),
          ],
        ),
      ),
    );
  }
}
