import 'package:flutter/material.dart';
import 'package:readally/database.dart'; // Import the DatabaseService
import 'package:readally/components/card.dart'; // Import BookDetailPage

class BooksListPage extends StatefulWidget {
  final String title;
  final List<dynamic> bookRefs; // Book references array
  final DatabaseService databaseService;

  BooksListPage({
    required this.title,
    required this.bookRefs,
    required this.databaseService,
  });

  @override
  State<BooksListPage> createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xffFFFAF5), // Background color
        foregroundColor: const Color(0xff001910), // Text color
      ),
      backgroundColor: const Color(0xffFFFAF5), // Page background
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: widget.databaseService.getBooksByReferences(widget.bookRefs), // Fetch books by references
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Loading indicator
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Error handling
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final books = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding to the left and right
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  final title = book['title'] ?? 'Untitled'; // Use the correct 'title' field
                  final coverUrl = book['cover'] ?? ''; // Use the correct 'cover' field
                  final summary = book['summ'] ?? ''; // Use the correct 'summ' field
                  final author = book['author'] ?? 'Unknown'; // Get author field
                  final rate = book['rate'] ?? 0.0; // Get rate field

                  return Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0), // More vertical padding
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0), // Rounded corners for the book cover
                          child: AspectRatio(
                            aspectRatio: 2 / 3, // Maintain aspect ratio (2:3) for book covers
                            child: coverUrl.isNotEmpty
                                ? Image.network(
                              coverUrl,
                              width: 180, // Increased width for a larger cover image
                              height: 235, // Increased height for a larger cover image
                              fit: BoxFit.cover, // Ensure the cover image fits properly
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error); // Error handling for the image
                              },
                            )
                                : const Icon(Icons.book), // Default icon if no image is available
                          ),
                        ),
                        title: Text(
                          title,
                          style: TextStyle(
                            fontSize: 24, // Larger text for title
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff001910), // Text color for title
                          ),
                        ),
                        subtitle: Text(
                          author,
                          style: TextStyle(
                            fontSize: 20, // Larger text for author
                            color: const Color(0xff385723), // Text color for author
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios, // Single green arrow
                          color: const Color(0xff385723), // Green color for arrow
                        ),
                        onTap: () {
                          // Navigate to BookDetailPage when a book is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailPage(
                                title: title,
                                coverUrl: coverUrl,
                                summary: summary,
                                author: author,
                                rating: rate, // Pass the rate field
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        color: Color(0xff385723), // Green divider color
                        thickness: 1.5, // Thickness of the divider
                      ),
                    ],
                  );
                },
              ),
            );
          }

          return const Center(child: Text('No books found!')); // Handle no data case
        },
      ),
    );
  }
}
