import 'package:flutter/material.dart';
import 'package:readally/bookspage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Boolean to toggle password visibility
  bool _isPasswordVisible = false;

  // TextEditingController to get email and password input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fake authentication method
  void _signIn() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email == 'ellie@email.com' && password == '123456789') {
      // Navigate to BooksPage if credentials are correct
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BooksPage(),
        ),
      );
    } else {
      // Show an error message if credentials are wrong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect email or password!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent resizing when keyboard appears
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFAF5),
        title: const Text(''),
      ),
      backgroundColor: const Color(0xffFFFAF5),
      body: Stack(
        children: [
          // Positioned Widgets
          Positioned(
            bottom: -20,
            left: 120,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/cuatebook.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Positioned(
            top: -150,
            left: 50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/circles.png',
                width: 500,
                height: 500,
              ),
            ),
          ),
          Positioned(
            top: 220,
            left: -220,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/bb.png',
                width: 500,
                height: 500,
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 27,
                      color: Color(0xff001910),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'You have been missed!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff001910),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),

                  // Email Label
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter your email:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff001910),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 7),

                  // Email TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _emailController, // Add controller for email input
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFC7D9B5)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff385723)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Colors.grey), // Add greyish hint style
                        fillColor: const Color(0xffFFFAF5),
                        filled: true,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Password Label
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter your password:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff001910),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 7),

                  // Password Field with Eye Icon
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: _passwordController, // Add controller for password input
                      obscureText: !_isPasswordVisible, // Toggle password visibility
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFC7D9B5)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff385723)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.grey), // Add greyish hint style
                        fillColor: const Color(0xffFFFAF5),
                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible; // Toggle the state
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  const SizedBox(height: 40),

                  // Sign In Button
                  ElevatedButton(
                    onPressed: _signIn, // Call the fake authentication function
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF385723),
                      minimumSize: const Size(247, 56),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Sign In!',
                      style: TextStyle(
                        color: Color(0xFFFFFAf5),
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
}
