import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green.shade700, // Dark green for the AppBar
        elevation: 0, // Remove the shadow for a cleaner look
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.green.shade50, // Light green background for the body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Header Section
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade400.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/profile_image.jpg'), // Replace with your profile image
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 16),
                  // Name
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Email or other info
                  Text(
                    'johndoe@example.com',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green.shade200, // Lighter green text for email
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            // Bio Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bio:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'I am an avid reader, passionate about literature and technology. Enjoying discovering new books every day!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green.shade600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            // Button Row Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Edit Profile Button
                ElevatedButton(
                  onPressed: () {
                    // Handle profile editing here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600, // Green button
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.green.shade400.withOpacity(0.5),
                    elevation: 5,
                  ),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                // Sign Out Button
                ElevatedButton(
                  onPressed: () {
                    // Handle sign out here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600, // Red for sign out
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.red.shade400.withOpacity(0.5),
                    elevation: 5,
                  ),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
