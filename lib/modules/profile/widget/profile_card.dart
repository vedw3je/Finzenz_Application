import 'package:finzenz_app/constants/app_colors.dart';
import 'package:finzenz_app/modules/profile/widget/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:finzenz_app/modules/home/model/user_model.dart';
import 'package:finzenz_app/prefservice.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: PrefService.getUser(),
      builder: (context, snapshot) {
        Widget content;

        if (snapshot.connectionState == ConnectionState.waiting) {
          content = const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          content = const Center(child: Text('Error loading user data'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          content = const Center(child: Text('No user logged in'));
        } else {
          final user = snapshot.data!;
          content = Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Profile Picture with shadow
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.8),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ProfilePicture(radius: 45),
                ),

                const SizedBox(width: 20),

                /// User details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user.fullName,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 16,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              user.email,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 16,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            user.phone,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.address,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black54,
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
          height: 180,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFE0F7F4), // light mint teal
                Color(0xFFB2EBF2), // soft teal
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.teal.withOpacity(0.5), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withOpacity(0.15),
                blurRadius: 12,
                spreadRadius: 2,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: content,
          ),
        );
      },
    );
  }
}
