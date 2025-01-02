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
  List<dynamic> _currentBookRefs = [];

  @override
  void initState() {
    super.initState();
    _currentBookRefs = List.from(widget.bookRefs);
  }

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
        future: widget.databaseService.getBooksByReferences(_currentBookRefs),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final books = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  final title = book['title'] ?? 'No Title';
                  final coverUrl = book['cover'] ?? '';
                  final summary = book['summ'] ?? 'No summary available';
                  final author = book['author'] ?? 'Unknown Author';
                  final rating = book['rate'] ?? '0';
                  final bookId = book['id'];

                  if (bookId == null) {
                    return const ListTile(
                      title: Text('Invalid book entry (missing ID)'),
                    );
                  }

                  return Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                        leading: GestureDetector(
                          onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetailPage(
                                  title: title,
                                  coverUrl: coverUrl,
                                  summary: summary,
                                  author: author,
                                  rating: rating,
                                ),
                              ),
                            );
                          },
                          child: coverUrl.isNotEmpty
                              ? Image.network(
                            coverUrl,
                            width: 50,
                            height: 70,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          )
                              : const Icon(Icons.book),
                        ),
                        title: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Color(0xff8b0000)),
                          onPressed: () {
                            _removeBookFromList(bookId);
                          },
                        ),
                      ),
                      Divider(
                        color: Color(0xff385723),
                        thickness: 1.5,
                        indent: 10,
                        endIndent: 10,
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

  void _removeBookFromList(String bookId) async {
    if (bookId.isEmpty) {
      print('Error: bookId is empty');
      return;
    }

    try {

      await widget.databaseService.removeBookFromList(widget.title, bookId);


      setState(() {
        _currentBookRefs.remove(bookId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book removed from the list.')),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
            'Failed to remove the book. The list may not exist. Please try again later.')),
      );
    }
  }
}
