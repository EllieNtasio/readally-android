import 'package:flutter/material.dart';
import 'database.dart'; // Η υπηρεσία της βάσης δεδομένων

class HomePage extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService(); // Δημιουργία instance της βάσης

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books List'), // Τίτλος της σελίδας
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: databaseService.getBooks(), // Φέρνουμε τη λίστα με τα βιβλία
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Δείκτης φόρτωσης
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Χειρισμός σφαλμάτων
          }

          if (snapshot.hasData) {
            final books = snapshot.data!; // Παίρνουμε τη λίστα των βιβλίων
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final title = book['title']; // Πρόσβαση στο πεδίο "title"
                return ListTile(
                  title: Text(title), // Εμφανίζουμε τον τίτλο του βιβλίου
                );
              },
            );
          }

          return const Center(child: Text('No books found!')); // Χειρισμός κενών δεδομένων
        },
      ),
    );
  }
}
