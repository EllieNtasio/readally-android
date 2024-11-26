import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String currentBio;

  // Constructor to accept the current profile data
  EditProfileScreen({
    required this.currentName,
    required this.currentEmail,
    required this.currentBio,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _bio;

  @override
  void initState() {
    super.initState();
    // Initialize the form fields with the current values
    _name = widget.currentName;
    _email = widget.currentEmail;
    _bio = widget.currentBio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
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
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage:
                              AssetImage('assets/images/snoopy.png'),
                              backgroundColor: Colors.black,
                            ),
                            Positioned.fill(
                              child: GestureDetector(
                                onTap: () {
                                  // Add functionality to change the profile picture here
                                  print("Change profile picture tapped!");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Edit your profile',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff001910),
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
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
                            child: TextFormField(
                              initialValue: _name,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                  color: Color(0xff385723),
                                ),
                                border: InputBorder.none,
                              ),
                              onSaved: (value) => _name = value ?? '',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
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
                            child: TextFormField(
                              initialValue: _email,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: Color(0xff385723),
                                ),
                                border: InputBorder.none,
                              ),
                              onSaved: (value) => _email = value ?? '',
                              validator: (value) {
                                if (value == null || !value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
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
                            child: TextFormField(
                              initialValue: _bio,
                              maxLines: 6,
                              decoration: InputDecoration(
                                labelText: 'Bio',
                                labelStyle: TextStyle(
                                  color: Color(0xff385723),
                                ),
                                border: InputBorder.none,
                              ),
                              onSaved: (value) => _bio = value ?? '',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your bio';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    _formKey.currentState?.save();

                                    // Prepare the updated data
                                    final updatedData = {
                                      'name': _name,
                                      'email': _email,
                                      'bio': _bio,
                                    };

                                    // Pop back to the previous screen with the updated data
                                    Navigator.pop(context, updatedData);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff385723),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  'Save Changes',
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
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
