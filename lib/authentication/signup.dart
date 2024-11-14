import 'package:flutter/material.dart';
import 'package:readally/bookspage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isTicked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFAF5),
        title: const Text(''),
      ),
      backgroundColor: const Color(0xffFFFAF5),
      body: Stack(
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
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  const SizedBox(height: 70),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BooksPage(),
                        ),
                      );
                    },
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
