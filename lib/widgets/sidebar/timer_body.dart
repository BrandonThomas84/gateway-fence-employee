import 'package:flutter/material.dart';

class TimerBody extends StatelessWidget {
  const TimerBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CLOCK STARTED: 12:34:45 PM',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w200,
            height: 1,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '01:23:45',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w200,
            height: 1,
          ),
        ),
      ],
    );
  }
}
