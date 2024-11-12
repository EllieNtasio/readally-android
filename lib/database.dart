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

  // Fetch all books (real-time stream)
  Stream<List<Map<String, dynamic>>> getBooksStream() {
    return _db.collection('books').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  // Fetch books by a filter ('author' or 'category') in real-time
  Stream<List<Map<String, dynamic>>> getBooksStreamByFilter(String filter, String value) {
    Query query = _db.collection('books');

    if (filter == 'author') {
      query = query.where('author', isEqualTo: value);
    } else if (filter == 'category') {
      query = query.where('category', isEqualTo: value);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  // Fetch books once by a filter (e.g., 'author' or 'category')
  Future<List<Map<String, dynamic>>> getBooksByFilter(String filter, String value) async {
    QuerySnapshot query = await _db.collection('books').where(filter, isEqualTo: value).get();
    return query.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // Fetch list names dynamically from the 'lists' collection
  Stream<List<Map<String, dynamic>>> getListNames() {
    return _db.collection('lists').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'listname': doc['listname'],  // List name field
        };
      }).toList();
    });
  }
}



