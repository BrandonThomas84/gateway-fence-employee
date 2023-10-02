// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'header_image.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    required this.imageSize,
  });

  final double imageSize;

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<AuthProvider>(context).user;

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderImage(
            imageSize: imageSize,
            borderThickness: 2,
          ),
          const SizedBox(height: 10),
          Text(
            user?.displayName ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 18),
          ),
          const Divider(color: AppColors.blueLight, thickness: 0.5),
          Text(
            user?.email ?? '',
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
          Text(
            user?.phoneNumber ?? '',
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
