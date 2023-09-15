import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  static const _profileImageDimension = 60.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 12,
              ),
            ),
            height: _profileImageDimension,
            width: _profileImageDimension,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_profileImageDimension / 2),
              child: Image.asset('assets/brandon.png'),
            ),
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
