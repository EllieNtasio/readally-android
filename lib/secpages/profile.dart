import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:readally/opening.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: const Color(0xff94AB71),
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFFFFFAF5),
        child: Stack(
          children: [
            Positioned(
              bottom: -80,
              left: -120,
              child: Image.asset(
                'assets/images/circles.png',
                width: 400,
                height: 400,
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xff94AB71),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 5,
                              left: 0,
                              child: Image.asset(
                                'assets/images/flbooks.png',
                                width: 190,
                                height: 190,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 230,
                              child: Image.asset(
                                'assets/images/flbooks.png',
                                width: 190,
                                height: 190,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage('assets/images/snoopy.png'),
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Ellie',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff001910),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        color: Color(0xffA6A6A6),
                      ),
                      SizedBox(width: 7),
                      Text(
                        'ellie@email.com',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffA6A6A6),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: Color(0xff385723),
                    thickness: 2,
                    indent: 40,
                    endIndent: 40,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FutureBuilder<int>(
                          future: _getBooksCount(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            if (snapshot.hasError) {
                              return Text('Error');
                            }
                            int booksCount = snapshot.data ?? 0;
                            return Row(
                              children: [
                                Icon(Icons.book, color: Color(0xff385723)),
                                SizedBox(width: 8),
                                Text(
                                  'Books: $booksCount',
                                  style: TextStyle(fontSize: 16, color: Color(0xff385723)),
                                ),
                              ],
                            );
                          },
                        ),
                        FutureBuilder<int>(
                          future: _getListsCount(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            if (snapshot.hasError) {
                              return Text('Error');
                            }
                            int listsCount = snapshot.data ?? 0;
                            return Row(
                              children: [
                                Icon(Icons.list, color: Color(0xff385723)),
                                SizedBox(width: 8),
                                Text(
                                  'Lists: $listsCount',
                                  style: TextStyle(fontSize: 16, color: Color(0xff385723)),
                                ),
                              ],
                            );
                          },
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Color(0xff385723)),
                            SizedBox(width: 8),
                            Text(
                              'Greece',
                              style: TextStyle(fontSize: 16, color: Color(0xff385723)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: Container(
                      width: 320,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xffEAF1E3),
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
                            'About me:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff001910),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'I am an avid reader, passionate about literature and technology. Enjoying discovering new books every day!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff385723),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Divider(
                    color: Color(0xff385723),
                    thickness: 2,
                    indent: 40,
                    endIndent: 40,
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff385723),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shadowColor: Colors.green.shade400.withOpacity(0.5),
                          elevation: 5,
                        ),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFFFAF5),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Opening()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff8b0000),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shadowColor: Colors.red.shade600.withOpacity(0.5),
                          elevation: 5,
                        ),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFFFAF5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int> _getListsCount() async {
    var querySnapshot = await FirebaseFirestore.instance.collection('lists').get();
    return querySnapshot.size;
  }

  Future<int> _getBooksCount() async {
    var querySnapshot = await FirebaseFirestore.instance.collection('books').get();
    return querySnapshot.size;
  }
}
