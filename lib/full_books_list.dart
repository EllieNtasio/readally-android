import 'package:flutter/material.dart';
import 'package:readally/components/card.dart'; // Import BookDetailPage
import 'database.dart'; // Import the DatabaseService

class BooksListPage extends StatelessWidget {
  final String title;
  final String filter;
  final String filterValue;
  final DatabaseService databaseService;

  BooksListPage({
    required this.title,
    required this.filter,
    required this.filterValue,
    required this.databaseService,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xffFFFAF5), // Background color
        foregroundColor: const Color(0xff001910), // Text color
      ),
      backgroundColor: const Color(0xffFFFAF5), // Page background
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: databaseService.getBooksByFilter(filter, filterValue), // Fetch all books for this category/author
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
                  final title = book['title']; // Use the correct 'title' field
                  final coverUrl = book['cover']; // Use the correct 'cover' field
                  final summary = book['summ']; // Use the correct 'summ' field
                  final author = book['author']; // Get author field
                  final rate = book['rate']; // Get rate field

                  return Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0), // More vertical padding
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0), // Rounded corners for the book cover
                          child: AspectRatio(
                            aspectRatio: 2 / 3, // Maintain aspect ratio (2:3) for book covers
                            child: Image.network(
                              coverUrl,
                              width: 180, // Increased width for a larger cover image
                              height: 235, // Increased height for a larger cover image
                              fit: BoxFit.cover, // Ensure the cover image fits properly
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error); // Error handling for the image
                              },
                            ),
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
                      // Removed the SizedBox here
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
