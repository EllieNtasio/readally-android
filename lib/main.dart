import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
      home: BooksPage(), // Navigate to the BooksPage
    );
  }
}

class BooksPage extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService(); // Create an instance of DatabaseService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: databaseService.getBooks(), // Fetch the list of books
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading indicator
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Error handling
          }

          if (snapshot.hasData) {
            final books = snapshot.data!; // Get the list of books
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final title = book['title']; // Access the title field
                return ListTile(
                  title: Text(title), // Display the title
                );
              },
            );
          }

          return Center(child: Text('No books found!')); // Handle no data case
        },
      ),
    );
  }
}