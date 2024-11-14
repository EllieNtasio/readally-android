import 'package:flutter/material.dart';
import 'package:readally/database.dart';
import 'package:readally/components/card.dart';

class BooksListPage extends StatefulWidget {
  final String title;
  final List<dynamic> bookRefs;
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
        backgroundColor: const Color(0xffFFFAF5),
        foregroundColor: const Color(0xff001910),
      ),
      backgroundColor: const Color(0xffFFFAF5),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: widget.databaseService.getBooksByReferences(widget.bookRefs),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Error handling
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final books = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  final title = book['title'] ?? 'Untitled';
                  final coverUrl = book['cover'] ?? '';
                  final summary = book['summ'] ?? '';
                  final author = book['author'] ?? 'Unknown';
                  final rate = book['rate'] ?? 0.0;

                  return Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: AspectRatio(
                            aspectRatio: 2 / 3, // Maintain aspect ratio (2:3) for book covers
                            child: coverUrl.isNotEmpty
                                ? Image.network(
                              coverUrl,
                              width: 180,
                              height: 235,
                              fit: BoxFit.cover, // Ensure the cover image fits properly
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            )
                                : const Icon(Icons.book),
                          ),
                        ),
                        title: Text(
                          title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff001910),
                          ),
                        ),
                        subtitle: Text(
                          author,
                          style: TextStyle(
                            fontSize: 20,
                            color: const Color(0xff385723),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: const Color(0xff385723),
                        ),
                        onTap: () {

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
                      ),
                      const Divider(
                        color: Color(0xff385723),
                        thickness: 1.5,
                      ),
                    ],
                  );
                },
              ),
            );
          }

          return const Center(child: Text('No books found!'));
        },
      ),
    );
  }
}
