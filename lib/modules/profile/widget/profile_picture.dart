import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final double radius;

  const ProfilePicture({Key? key, required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Icon(
        Icons.person,
        size: radius,
        color: Colors.grey.shade600,
      ),
    );
  }
}
