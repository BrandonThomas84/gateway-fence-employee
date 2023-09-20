import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    super.key,
    required this.imageSize,
    this.borderThickness = 2,
  });

  final double imageSize;
  final double borderThickness;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: borderThickness,
        ),
      ),
      height: imageSize,
      width: imageSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(imageSize / 2),
        child: Image.asset('assets/logo_transparent.png'),
      ),
    );
  }
}
