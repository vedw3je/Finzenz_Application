import 'package:finzenz_app/constants/app_colors.dart';
import 'package:finzenz_app/modules/profile/widget/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:finzenz_app/modules/home/model/user_model.dart';
import 'package:finzenz_app/prefservice.dart';

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: PrefService.getUser(),
      builder: (context, snapshot) {
        Widget content;

        if (snapshot.connectionState == ConnectionState.waiting) {
          content = Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          content = Center(child: Text('Error loading user data'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          content = Center(child: Text('No user logged in'));
        } else {
          final user = snapshot.data!;
          content = Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfilePicture(radius: 40),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      
                      Container(
                        width: 20,
                        height: 40,
                        color: Colors.amber,
                      ),
                      
                      SizedBox(height: 8),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        user.phone,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            gradient: AppColors.mainGradientLight,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: content,
        );
      },
    );
  }
}
