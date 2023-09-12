import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';

class EventItem extends StatelessWidget {
  final String text;
  final String time;
  final VoidCallback? onTap;

  const EventItem({
    super.key,
    required this.text,
    required this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.edit,
                color: AppColors.blackLight,
                size: 20,
              ),
              const SizedBox(height: 5),
              Text(time),
            ],
          ),
          // const Sidebar(),
        ],
      ),
    );
  }
}
