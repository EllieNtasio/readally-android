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

  // Existing method: Fetch all books (now using a Stream)
  Stream<List<Map<String, dynamic>>> getBooksStream() {
    // Listening to the entire 'books' collection for changes in real-time
    return _db.collection('books').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  // New method: Fetch books by filter (e.g., 'author' or 'category') in real-time
  Stream<List<Map<String, dynamic>>> getBooksStreamByFilter(String filter, String value) {
    // Listening to the books collection with a filter for real-time changes
    Query query = _db.collection('books');

    // Apply the filter based on the input
    if (filter == 'author') {
      query = query.where('author', isEqualTo: value);
    } else if (filter == 'category') {
      query = query.where('category', isEqualTo: value);
    }

    // Return a stream of documents based on the query
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  // Method to fetch books once by a filter (e.g., 'author' or 'category')
  Future<List<Map<String, dynamic>>> getBooksByFilter(String filter, String value) async {
    QuerySnapshot query = await _db.collection('books').where(filter, isEqualTo: value).get();
    return query.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}

