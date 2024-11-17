import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch books based on references (from the 'books' field in the 'lists' collection)
  Future<List<Map<String, dynamic>>> getBooksByReferences(List<dynamic> bookRefs) async {
    final booksRef = FirebaseFirestore.instance.collection('books');
    List<Map<String, dynamic>> booksList = [];

    // Loop through each bookRef ID and fetch its details
    for (var ref in bookRefs) {
      var doc = await booksRef.doc(ref).get();  // Get each book by its ID

      if (doc.exists) {
        var data = doc.data();
        if (data != null) {
          data['id'] = doc.id;  // Add the document ID to the book data
          booksList.add(data);
        }
      }
    }

    return booksList;
  }

  // Stream to fetch lists in real-time from 'lists' collection
  Stream<List<Map<String, dynamic>>> getListsStream() {
    return _db.collection('lists').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'listname': doc['listname'],  // The name of the list
          'books': doc['books'] ?? [],  // List of book IDs (array of strings)
        };
      }).toList();
    });
  }

  // Fetch list details by ID
  Future<Map<String, dynamic>> getListDetails(String listId) async {
    try {
      DocumentSnapshot snapshot = await _db.collection('lists').doc(listId).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        throw Exception("List not found!");
      }
    } catch (e) {
      print('Error getting list details: $e');
      throw e;
    }
  }

  // Fetch a single book by its ID
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

  // Update book rating (as a String) in 'books' collection
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

  // Remove book from the list by listname and bookId
  Future<void> removeBookFromList(String listname, String bookId) async {
    print('Attempting to remove bookId: $bookId from list: $listname');

    try {
      // Query for the document where the listname field matches the provided listname
      final querySnapshot = await FirebaseFirestore.instance
          .collection('lists')
          .where('listname', isEqualTo: listname)
          .limit(1)
          .get();

      // Check if any document was found
      if (querySnapshot.docs.isEmpty) {
        print('Error: No list document found with the name "$listname"');
        throw Exception('List document does not exist');
      }

      // Get the first document (since we limited the query to 1 result)
      final docRef = querySnapshot.docs.first.reference;

      // Attempt to remove the bookId from the 'books' array in the list document
      await docRef.update({
        'books': FieldValue.arrayRemove([bookId]),
      });

      // After update, check the new array of books to verify the removal
      final updatedDoc = await docRef.get();
      final updatedBooks = updatedDoc.data()?['books'];
      print('Updated books array: $updatedBooks');

      // If the book ID is still in the array, log an error
      if (updatedBooks != null && updatedBooks.contains(bookId)) {
        print('Error: bookId still in the array after removal');
      } else {
        print('Successfully removed bookId: $bookId from the list');
      }
    } catch (e) {
      print('Error while removing book from Firestore: $e');
      rethrow; // Re-throw the error so it can be caught in the calling function
    }
  }

  // Update the book list (update the list of book references)
  Future<void> updateBookList(String listId, List<dynamic> updatedBookRefs) async {
    try {
      // Update the 'books' field in the list document with the new array
      await _db.collection('lists').doc(listId).update({
        'books': updatedBookRefs,
      });
      print('Book list updated for $listId');
    } catch (e) {
      print('Error updating book list: $e');
    }
  }

  // Delete a book from the 'books' collection (optional functionality)
  Future<void> deleteBookFromCollection(String bookId) async {
    try {
      await _db.collection('books').doc(bookId).delete();
      print('Book deleted from collection');
    } catch (e) {
      print('Error deleting book from collection: $e');
    }
  }
}
