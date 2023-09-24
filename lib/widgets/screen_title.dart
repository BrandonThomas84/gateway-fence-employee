// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.black,
        // border: Border.symmetric(
        //   horizontal: BorderSide(
        //     color: AppColors.greyLight,
        //     width: 1,
        //   ),
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.greyLight,
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          if (subtitle != null)
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                child: Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
