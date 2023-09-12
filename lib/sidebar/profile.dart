import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  static const _profileHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
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
            height: _profileHeight,
            width: _profileHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_profileHeight / 2),
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
          const Text(
            'brandon@hackyhapper.com | 530.774.7991',
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
