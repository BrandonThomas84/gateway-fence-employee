import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/util/config.dart';
import '_util.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return defaultScreenScaffold(
      title: companyName,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(
              bottom: BorderSide(
                color: AppColors.greyLight,
                width: 1,
              ),
            ),
          ),
          child: const Column(
            children: [
              Text("some stuff"),
            ],
          ),
        ),
      ],
    );
  }
}
