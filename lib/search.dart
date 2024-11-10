import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:readally/components/card.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  List<Map<String, dynamic>> searchResults = [];
  bool isSearchingByTitle = true; // Default to searching by title

  // Function to search books in Firebase
  void searchBooks(String query) async {
    if (query.isNotEmpty) {
      // Perform a case-insensitive search for books by title and author
      Query queryReference = FirebaseFirestore.instance.collection('books');

      if (isSearchingByTitle) {
        queryReference = queryReference
            .where('title', isGreaterThanOrEqualTo: query)
            .where('title', isLessThanOrEqualTo: query + '\uf8ff'); // Search range for title
      } else {
        queryReference = queryReference
            .where('author', isGreaterThanOrEqualTo: query)
            .where('author', isLessThanOrEqualTo: query + '\uf8ff'); // Search range for author
      }

      final result = await queryReference.get();

      setState(() {
        // Extract the data from Firestore documents
        searchResults = result.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } else {
      // If the search query is empty, clear the results
      setState(() {
        searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFAF5), // Background color
      appBar: AppBar(
        title: const Text('Search Books'),
        backgroundColor: const Color(0xffFFFAF5), // Custom AppBar color
        actions: [
          IconButton(
            icon: Icon(isSearchingByTitle ? Icons.book : Icons.person),
            onPressed: () {
              setState(() {
                // Toggle between searching by title and author
                isSearchingByTitle = !isSearchingByTitle;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar Container
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFC7D9B5), // Green background for search container
                borderRadius: BorderRadius.circular(30), // Rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.green), // Search icon
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by ${isSearchingByTitle ? 'title' : 'author'}...', // Dynamically change hintText
                          border: InputBorder.none, // Remove default underline
                        ),
                        onChanged: (value) {
                          setState(() {
                            query = value;
                          });
                          // Perform search if the query is not empty
                          searchBooks(query);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Search Results Display
          Expanded(
            child: searchResults.isEmpty
                ? const Center(child: Text('No books found')) // Show if no results
                : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final book = searchResults[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to the BookDetailPage when the book is tapped
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
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        // Book cover image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0), // Rounded corners
                          child: Image.network(
                            book['cover'], // Ensure the 'cover' field is a valid image URL
                            width: 70,
                            height: 100, // Adjust size for cover
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error); // Error handling for the image
                            },
                          ),
                        ),
                        const SizedBox(width: 16), // Spacing between cover and text

                        // Book title and author information
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book['title'],
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff001910), // Text color for title
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                book['author'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54, // Text color for author
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Optional action on the right side (such as more icon)
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
