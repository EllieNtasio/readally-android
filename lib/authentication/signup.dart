import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:readally/bookspage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isTicked = true;
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (!_isTicked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must agree to the Terms and Conditions')),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BooksPage()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFAF5),
        title: const Text(''),
      ),
      backgroundColor: const Color(0xffFFFAF5),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: -140,
              left: 80,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/circles.png',
                  width: 500,
                  height: 500,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Create your Account',
                      style: TextStyle(
                        fontSize: 27,
                        color: Color(0xff001910),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Fill your information below',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff001910),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Enter a username:',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff001910),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFC7D9B5)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xff385723)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Username',
                          hintStyle: const TextStyle(color: Colors.grey),
                          fillColor: const Color(0xffFFFAF5),
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        controller: _emailController,
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
                          hintStyle: const TextStyle(color: Colors.grey),
                          fillColor: const Color(0xffFFFAF5),
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
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
                          hintStyle: const TextStyle(color: Colors.grey),
                          fillColor: const Color(0xffFFFAF5),
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19.0),
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: 1.0,
                            child: Checkbox(
                              value: _isTicked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isTicked = value!;
                                });
                              },
                              shape: const CircleBorder(),
                              activeColor: const Color(0xFF385723),
                            ),
                          ),
                          const Text(
                            'Agree with Terms and Conditions',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF385723),
                        minimumSize: const Size(247, 56),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Sign Up!',
                        style: TextStyle(
                          color: Color(0xFFFFFAF5),
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
      ),
    );
  }
}
