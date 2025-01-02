import 'package:flutter/material.dart';
import 'package:readally/database.dart'; // Make sure your database service is correctly imported

class ARBooksPage extends StatelessWidget {
  const ARBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xffFFFAF5),
      ),
      backgroundColor: const Color(0xffFFFAF5),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF9EDB2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'You scanned something?',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff385723),
                          ),
                          maxLines: 2,  // Limit to 2 lines
                          overflow: TextOverflow.ellipsis,  // Handle overflow
                        ),
                        SizedBox(height: 8),
                        Text(
                          'You can find it here!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff385723),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/images/pana.png',
                    width: 160,
                    height: 130,
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            ),
          ),
          // Fetch and display the list with the ID 'F57etWoaNdSGYQ3RmTAo'
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: databaseService.getBooksStreamByListId('F57etWoaNdSGYQ3RmTAo'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData) {
                  final books = snapshot.data!;

                  if (books.isEmpty) {
                    return const Center(child: Text('No books found in this list.'));
                  }

                  return BooksListSection(
                    title: 'Add to your lists',
                    books: books,
                    databaseService: databaseService,
                    backgroundColor: const Color(0xffFFFAF5),
                  );
                }

                return const Center(child: Text('List not found!'));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BooksListSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> books;
  final DatabaseService databaseService;
  final Color backgroundColor;

  const BooksListSection({
    required this.title,
    required this.books,
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
          Padding(
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
                const SizedBox(height: 4),
                Container(
                  height: 2,
                  width: 230,
                  color: const Color(0xFF385723),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Make this a vertical list instead of horizontal
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final coverUrl = book['cover'];  // Assuming you have a field 'cover' in your book data
                final title = book['title']; // Assuming you have a field 'title' in your book data
                final author = book['author']; // Assuming you have a field 'author' in your book data

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      // Book cover image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          coverUrl,
                          width: 100,
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Book title and author next to the cover
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff001910),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              author,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff385723),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
