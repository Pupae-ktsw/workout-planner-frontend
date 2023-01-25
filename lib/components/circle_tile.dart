import 'package:flutter/material.dart';

class CircleTile extends StatelessWidget {
  final String imagePath;
  const CircleTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(imagePath),
    );
  }
}
