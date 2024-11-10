/*import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference booksCollection =
  FirebaseFirestore.instance.collection('books'); // Reference to the 'books' collection

  // Method to get the list of books
  Future<List<Map<String, dynamic>>> getBooks() async {
    try {
      QuerySnapshot snapshot = await booksCollection.get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error fetching books: $e');
      return [];
    }
  }
}  */

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Existing method: Fetch all books
  Future<List<Map<String, dynamic>>> getBooks() async {
    QuerySnapshot query = await _db.collection('books').get();
    return query.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // New method: Fetch books by filter (e.g., 'author' or 'category')
  Future<List<Map<String, dynamic>>> getBooksByFilter(String filter, String value) async {
    QuerySnapshot query = await _db.collection('books').where(filter, isEqualTo: value).get();
    return query.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}

