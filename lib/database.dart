import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch books based on references (from the 'books' field in the 'lists' collection)
  Future<List<Map<String, dynamic>>> getBooksByReferences(List<dynamic> bookIds) async {
    List<Map<String, dynamic>> books = [];

    // Iterate through each book ID in the list and fetch its data
    for (var bookId in bookIds) {
      try {
        DocumentSnapshot bookDoc = await _db.collection('books').doc(bookId).get();
        if (bookDoc.exists) {
          books.add(bookDoc.data() as Map<String, dynamic>);
        }
      } catch (e) {
        print('Error fetching book with ID $bookId: $e');
      }
    }

    return books;  // Return the list of books
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

  // Fetch list by ID (if needed in future operations)
  Future<DocumentSnapshot> getListById(String listId) async {
    return await _db.collection('lists').doc(listId).get();
  }

  // Method to remove a book from a list
  Future<void> removeBookFromList(String bookId, String listName) async {
    try {
      // Get the reference to the specific list document by list name
      final listDocRef = _db.collection('lists').doc(listName);

      // Perform the update operation: remove the bookId from the 'books' array in the 'lists' collection
      await listDocRef.update({
        'books': FieldValue.arrayRemove([bookId]), // Removes bookId from the 'books' array
      });
      print('Book removed from list $listName');
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
      print('Book moved from $currentListId to $targetListId');
    } catch (e) {
      print('Error moving book: $e');
    }
  }

  // Method to update the rating of a book as a String
  Future<void> updateBookRating(String bookId, String newRating) async {
    try {
      await _db.collection('books').doc(bookId).update({
        'rate': newRating,  // Store the rating as a String
      });
      print('Book rating updated');
    } catch (e) {
      print('Error updating book rating: $e');
    }
  }

  // Method to get a book by ID
  Future<Map<String, dynamic>?> getBookById(String bookId) async {
    try {
      DocumentSnapshot bookDoc = await _db.collection('books').doc(bookId).get();
      if (bookDoc.exists) {
        return bookDoc.data() as Map<String, dynamic>;
      } else {
        return null; // Book not found
      }
    } catch (e) {
      print('Error fetching book by ID: $e');
      return null;
    }
  }

  // Method to delete a book only from the lists, not from the 'books' collection
  Future<void> removeBookFromAllLists(String bookId) async {
    try {
      // 1. Get all lists where the book is referenced
      var listsSnapshot = await _db.collection('lists').get();

      for (var listDoc in listsSnapshot.docs) {
        String listId = listDoc.id;
        List<dynamic> bookRefs = List.from(listDoc['books'] ?? []);

        // 2. If the book exists in the list, remove it from the list's 'books' array
        if (bookRefs.contains(bookId)) {
          await removeBookFromList(bookId, listId);
        }
      }
      print('Book removed from all lists');
    } catch (e) {
      print('Error removing book from all lists: $e');
    }
  }
}
