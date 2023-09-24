// Flutter imports:
import 'package:flutter/material.dart';

class ShiftDaySubitle extends StatelessWidget {
  final String subTitle;

  const ShiftDaySubitle(
    this.subTitle, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 5,
            right: 10,
            bottom: 5,
          ),
          child: Text(
            'Total Hours: $subTitle',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
