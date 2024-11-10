import 'package:flutter/material.dart';
import 'package:readally/profile.dart';
import 'package:readally/newlist.dart';
import 'package:readally/settings.dart';
import 'package:readally/search.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFFFFFAF5),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[

            Container(
              color: Color(0xFF94AB71),
              width: double.infinity,
              height: 180.0,
              padding: EdgeInsets.all(14.0),
              child: Row(
                children: [

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xff385723),
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage('assets/images/snoopy.png'),
                    ),
                  ),
                  SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'User Name',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          'user@example.com',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: Icon(Icons.person, color: Color(0xff001910), size: 30),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            SizedBox(height: 10),


            ListTile(
              leading: Icon(Icons.list, color: Color(0xff001910), size: 30),
              title: Text(
                'New List',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewListScreen()),
                );
              },
            ),
            SizedBox(height: 10),


            ListTile(
              leading: Icon(Icons.search, color: Color(0xff001910), size: 30),
              title: Text(
                'Search',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
            ),
            SizedBox(height: 10),


            ListTile(
              leading: Icon(Icons.settings, color: Color(0xff001910), size: 30),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}