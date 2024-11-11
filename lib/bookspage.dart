import 'package:flutter/material.dart';
import 'package:readally/components/card.dart';
import 'database.dart';
import 'full_books_list.dart';
import 'package:readally/components/drawer.dart'; // Import the drawer.dart file

class BooksPage extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();

  BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        backgroundColor: const Color(0xffFFFAF5),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu), // Keep the menu icon
              onPressed: () {
                Scaffold.of(context).openDrawer(); // This now works because Builder gives the correct context
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt), // Camera icon on the right
            onPressed: () {
              // Add functionality for camera icon here, if needed
              print("Camera icon pressed"); // Example action
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xffFFFAF5),
      drawer: AppDrawer(), // Add the Drawer to the Scaffold
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: BooksListSection(
              title: 'Stephen King Books',
              filter: 'author',
              filterValue: 'Stephen King',
              databaseService: databaseService,
              backgroundColor: const Color(0xffFFFAF5),
            ),
          ),
          Flexible(
            flex: 1,
            child: BooksListSection(
              title: 'Academic Books',
              filter: 'category',
              filterValue: 'Academic',
              databaseService: databaseService,
              backgroundColor: const Color(0xffFFFAF5),
            ),
          ),
          Flexible(
            flex: 1,
            child: BooksListSection(
              title: 'Best Sellers',
              filter: 'category',
              filterValue: 'Best Seller',
              databaseService: databaseService,
              backgroundColor: const Color(0xffFFFAF5),
            ),
          ),
        ],
      ),
    );
  }
}

// Section for each book list (title + horizontal scrollable list of books)
class BooksListSection extends StatelessWidget {
  final String title;
  final String filter;
  final String filterValue;
  final DatabaseService databaseService;
  final Color backgroundColor;

  BooksListSection({
    required this.title,
    required this.filter,
    required this.filterValue,
    required this.databaseService,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to full list page when the section title is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BooksListPage(
                    title: title,
                    filter: filter,
                    filterValue: filterValue,
                    databaseService: databaseService,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff001910),
                    ),
                  ),
                  const SizedBox(height: 4), // Small gap between title and line
                  Container(
                    height: 2, // Thin green line
                    width: 230, // Adjust the width of the line
                    color: const Color(0xFF385723),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: databaseService.getBooksStreamByFilter(filter, filterValue),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator()); // Loading indicator
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}')); // Error handling
                }

                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final books = snapshot.data!;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      final title = book['title'];
                      final coverUrl = book['cover'];
                      final summary = book['summ'];
                      final author = book['author'];
                      final rate = book['rate'];

                      return GestureDetector(
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
                                rating: rate,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Material(
                            elevation: 4.0, // Elevation to give a floating effect
                            borderRadius: BorderRadius.circular(12.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0), // Rounded corners for the book cover
                              child: Image.network(
                                coverUrl,
                                width: 100,
                                height: 130, // Adjust size to control cover image dimensions
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error); // Error handling for the image
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                return const Center(child: Text('No books found!')); // Handle no data case
              },
            ),
          ),
        ],
      ),
    );
  }
}
