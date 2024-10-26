import 'package:cloud_firestore/cloud_firestore.dart';

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
}
