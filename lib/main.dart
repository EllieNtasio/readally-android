import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'opening.dart'; // Import the Opening widget
import 'package:readally/bookspage.dart';
import 'database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Opening(),
    );
  }
}
