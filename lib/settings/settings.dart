import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:readally/settings/clicked.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAf5),
      body: Stack(
        children: [
          Positioned(
            top: -110,
            right: -50,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 120, 155, 109).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 2),
                const Text(
                  'SETTINGS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Color(0xFF001910),
                    fontSize: 34,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 50),

                // Κουτιά ρυθμίσεων
                _buildSettingOption(context, Icons.account_circle, 'Login & Security', const LoginSecurityPage()),
                const SizedBox(height: 35),
                _buildSettingOption(context, Icons.notifications, 'Notifications', const NotificationsPage()),
                const SizedBox(height: 35),
                _buildSettingOption(context, Icons.ads_click, 'Interest Based-Ads', const InterestBasedAdsPage()),
                const SizedBox(height: 35),
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
        ],
      ),
    );
  }

  // Μέθοδος για τη δημιουργία κουτιών ρυθμίσεων και πλοήγησης με floating και elevation
  Widget _buildSettingOption(BuildContext context, IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Material(
        elevation: 3, // Εφαρμογή elevation για floating εφέ
        borderRadius: BorderRadius.circular(13), // Στρογγυλεμένες γωνίες
        shadowColor: Colors.grey.withOpacity(0.3), // Χρώμα της σκιάς
        child: Container(
          width: 298,
          height: 53,
          decoration: BoxDecoration(
            color: const Color(0xFFC7D9B5), // Χρώμα κουτιού
            borderRadius: BorderRadius.circular(13), // Στρογγυλεμένες γωνίες
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: const Color.fromARGB(255, 7, 6, 4)), // Εικονίδιο
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