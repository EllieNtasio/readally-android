import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:readally/components/card.dart';
import '../bookspage.dart'; // Import BooksPage for access to the lists

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  List<Map<String, dynamic>> searchResults = [];

  final BooksPage booksPage = BooksPage(); // Create instance of BooksPage

  // Function to search books by both title and author in Firebase
  void searchBooks(String query) async {
    if (query.isNotEmpty) {
      // Perform a case-insensitive search for books by title
      final titleResults = await FirebaseFirestore.instance
          .collection('books')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: query + '\uf8ff') // Search range for title
          .get();

      // Perform a case-insensitive search for books by author
      final authorResults = await FirebaseFirestore.instance
          .collection('books')
          .where('author', isGreaterThanOrEqualTo: query)
          .where('author', isLessThanOrEqualTo: query + '\uf8ff') // Search range for author
          .get();

      // Combine title and author results while avoiding duplicates
      final combinedResults = {
        ...titleResults.docs.map((doc) => {'id': doc.id, ...doc.data()}),
        ...authorResults.docs.map((doc) => {'id': doc.id, ...doc.data()}),
      };

      setState(() {
        // Update the search results
        searchResults = combinedResults.map((result) => result as Map<String, dynamic>).toList();
      });
    } else {
      setState(() {
        searchResults = []; // Clear the search results
      });
    }
  }

  // Function to check if the book is in any of the predefined lists
  Future<bool> isBookInAnyList(String bookId) async {
    // Fetch the books from each list using database service
    List<Map<String, dynamic>> stephenKingBooks = await booksPage.databaseService.getBooksByFilter('author', 'Stephen King');
    List<Map<String, dynamic>> academicBooks = await booksPage.databaseService.getBooksByFilter('category', 'Academic');
    List<Map<String, dynamic>> bestSellers = await booksPage.databaseService.getBooksByFilter('category', 'Best Seller');

    // Check if the book exists in any of these lists
    bool isInList = stephenKingBooks.any((book) => book['id'] == bookId) ||
        academicBooks.any((book) => book['id'] == bookId) ||
        bestSellers.any((book) => book['id'] == bookId);

    return isInList;
  }

  // Show a dialog to move the book to an existing list (only if the book is not already in a list)
  void showMoveToListDialog(BuildContext context, String bookId, String bookTitle, Map<String, dynamic> bookData) {
    // Available lists and their corresponding filters and filter values
    List<Map<String, dynamic>> availableLists = [
      {'name': 'Stephen King Books', 'filter': 'author', 'filterValue': 'Stephen King'},
      {'name': 'Academic Books', 'filter': 'category', 'filterValue': 'Academic'},
      {'name': 'Best Sellers', 'filter': 'category', 'filterValue': 'Best Seller'},
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Move "$bookTitle" to a list'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: availableLists.map((listInfo) {
              return ListTile(
                title: Text(listInfo['name']),
                onTap: () async {
                  // Update the book's filter field in the database
                  await FirebaseFirestore.instance
                      .collection('books')
                      .doc(bookId) // Use the document ID to update the existing entry
                      .update({
                    listInfo['filter']: listInfo['filterValue'], // Update the correct filter
                  });

                  Navigator.pop(context); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Moved "$bookTitle" to ${listInfo['name']}')),
                  );
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFAF5),
      appBar: AppBar(
        title: const Text('Search Books'),
        backgroundColor: const Color(0xffFFFAF5),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFC7D9B5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.green),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search books by title or author...',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            query = value;
                          });
                          searchBooks(query);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: searchResults.isEmpty
                ? const Center(child: Text('Read something new? Search to put on your list!'))
                : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final book = searchResults[index];
                return FutureBuilder<bool>(
                  future: isBookInAnyList(book['id']),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator(); // Loading indicator while we check the list
                    }

                    final bool isInList = snapshot.data!;

                    return GestureDetector(
                      onTap: () async {
                        if (isInList) {
                          // If the book is in a list, just navigate to BookDetailPage (no move option)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailPage(
                                title: book['title'],
                                coverUrl: book['cover'],
                                summary: book['summary'],
                                author: book['author'],
                                rating: book['rating'].toString(),
                              ),
                            ),
                          );
                        } else {
                          // Show a dialog to move the book to a list if it's not in any list
                          showMoveToListDialog(context, book['id'], book['title'], book);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                book['cover'],
                                width: 70,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book['title'],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff001910),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    book['author'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Green tick if the book is in a list
                            if (isInList)
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            else
                              const Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}