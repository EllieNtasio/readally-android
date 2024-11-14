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

  // Fetch list names dynamically from the 'lists' collection in real-time
  Stream<List<Map<String, dynamic>>> getListsStream() {
    return _db.collection('lists').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'listname': doc['listname'],  // List name
          'books': doc['books'] ?? [],  // Array of book IDs (strings)
        };
      }).toList();
    });
  }

  // Fetch books based on references (from the 'books' field in the 'lists' collection)
  Future<List<Map<String, dynamic>>> getBooksByReferences(List<dynamic> bookIds) async {
    List<Map<String, dynamic>> books = [];
    for (var bookId in bookIds) {
      // Fetch the book document using the book ID (convert ID to a reference)
      DocumentSnapshot bookDoc = await _db.collection('books').doc(bookId).get();
      if (bookDoc.exists) {
        books.add(bookDoc.data() as Map<String, dynamic>);
      }
    }
    return books;
  }

  Future<DocumentSnapshot> getListById(String listId) async {
    return await _db.collection('lists').doc(listId).get();
  }

  Future<void> updateList(String listId, Map<String, dynamic> data) async {
    return await _db.collection('lists').doc(listId).update(data);
  }

  // Fetch list names and books dynamically (previous method)
  Stream<List<Map<String, dynamic>>> getListNamesAndBooks() {
    return _db.collection('lists').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'listname': doc['listname'],  // List name field
          'books': doc['books'] ?? [],  // Books is an array, default to empty if null
        };
      }).toList();
    });
  }

  // Method to remove a book from a list
  Future<void> removeBookFromList(String bookId, String listId) async {
    try {
      await _db.collection('lists').doc(listId).update({
        'books': FieldValue.arrayRemove([bookId]),
      });
    } catch (e) {
      print('Error removing book from list: $e');
    }
  }

  // Method to move a book to another list
  Future<void> moveBookToAnotherList(String bookId, String currentListId, String targetListId) async {
    try {
      // 1. Remove book from the current list
      await removeBookFromList(bookId, currentListId);

      // 2. Add book to the target list
      await _db.collection('lists').doc(targetListId).update({
        'books': FieldValue.arrayUnion([bookId]),
      });
    } catch (e) {
      print('Error moving book: $e');
    }
  }
}
