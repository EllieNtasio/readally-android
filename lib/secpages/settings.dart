import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:readally/secpages/clicked.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xffFFFAF5),
      ),
      backgroundColor: const Color(0xFFFFFAf5),
      body: Stack(
        children: [
          Positioned(
            top: -40,
            left: 220,
            child: Image.asset(
              'assets/images/circles.png',
              width: 300,
              height: 300,
            ),
          ),
          Positioned(
            bottom: -40,
            right: 140,
            child: Image.asset(
              'assets/images/bb.png',
              width: 400,
              height: 400,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 0),
                  Text(
                    'SETTINGS',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff001910),
                    ),
                  ),
                  const SizedBox(height: 35),
                  _buildSettingOption(context, Icons.account_circle, 'Login & Security', const LoginSecurityPage()),
                  const SizedBox(height: 40),
                  _buildSettingOption(context, Icons.notifications, 'Notifications', const NotificationsPage()),
                  const SizedBox(height: 40),
                  _buildSettingOption(context, Icons.ads_click, 'Interest Based-Ads', const InterestBasedAdsPage()),
                  const SizedBox(height: 40),
                  _buildSettingOption(context, Icons.access_alarm, 'Accessibility', const AccessibilityPage()),
                  const SizedBox(height: 50),
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

  Widget _buildSettingOption(BuildContext context, IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(13),
        shadowColor: Colors.grey.withOpacity(0.3),
        child: Container(
          width: 298,
          height: 53,
          decoration: BoxDecoration(
            color: const Color(0xFFC7D9B5),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: const Color.fromARGB(255, 7, 6, 4)),
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
