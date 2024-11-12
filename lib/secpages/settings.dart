import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:readally/secpages/clicked.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xffFFFAF5),
      ),
      backgroundColor: const Color(0xFFFFFAf5),
      body: Stack(
        children: [
          // First Positioned widget with an image asset
          Positioned(
            top: -40,
            left: 250,
            child: Image.asset(
              'assets/images/circles.png',
              width: 300,
              height: 300,
            ),
          ),

          // Second Positioned widget with an image asset
          Positioned(
            bottom: -40,
            right: 180,
            child: Image.asset(
              'assets/images/bb.png',
              width: 400,
              height: 400,
            ),
          ),

          // Main content with setting options
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50), // Adjusted the padding to move the content higher
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start, // Aligning the content at the top
                children: [
                  const SizedBox(height: 100),
                  // Setting boxes with reduced space
                  _buildSettingOption(context, Icons.account_circle, 'Login & Security', const LoginSecurityPage()),
                  const SizedBox(height: 50), // Reduced spacing between options
                  _buildSettingOption(context, Icons.notifications, 'Notifications', const NotificationsPage()),
                  const SizedBox(height: 50),
                  _buildSettingOption(context, Icons.ads_click, 'Interest Based-Ads', const InterestBasedAdsPage()),
                  const SizedBox(height: 50),
                  _buildSettingOption(context, Icons.access_alarm, 'Accessibility', const AccessibilityPage()),

                  const SizedBox(height: 60),

                  ElevatedButton(
                    onPressed: () {
                      print('Changes saved');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF385723),
                      minimumSize: const Size(252, 56),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                        color: Color(0xFFFFFAF5),
                        fontFamily: 'Inter',
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to create setting option boxes and navigation with floating effect and elevation
  Widget _buildSettingOption(BuildContext context, IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Material(
        elevation: 3, // Floating effect
        borderRadius: BorderRadius.circular(13), // Rounded corners
        shadowColor: Colors.grey.withOpacity(0.3), // Shadow color
        child: Container(
          width: 298,
          height: 53,
          decoration: BoxDecoration(
            color: const Color(0xFFC7D9B5), // Box color
            borderRadius: BorderRadius.circular(13), // Rounded corners
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: const Color.fromARGB(255, 7, 6, 4)), // Icon
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
