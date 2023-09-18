import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';

import 'profile_image.dart';

class Profile extends StatelessWidget {
  final double imageSize;

  const Profile({
    Key? key,
    required this.imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileImage(
            imageSize: imageSize,
            borderThickness: 12,
          ),
          const SizedBox(height: 10),
          const Text(
            'Brandon Thomas',
            style: TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 18),
          ),
          const Text('Project Lead'),
          const Divider(color: AppColors.blueLight, thickness: 0.5),
          const Text(
            'brandon@hackyhapper.com',
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
          const Text(
            '530.774.7991',
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
