import 'package:flutter/material.dart';
import 'package:readally/components/card.dart';
import 'package:readally/database.dart';
import 'package:readally/components/drawer.dart';
import 'package:readally/components/full_books_list.dart';
import 'package:readally/secpages/arbooks.dart';

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
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ARBooksPage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xffFFFAF5),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFC7D9B5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Ellie!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF385723),
                        ),
                      ),
                      SizedBox(height: 9),
                      Text(
                        'Ready to explore more books?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color(0xffF385723),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/cuate.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: databaseService.getListsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final lists = snapshot.data!;


                  final filteredLists = lists.where((list) {

                    return list['listname'] != 'arbooks';
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredLists.length,
                    itemBuilder: (context, index) {
                      final list = filteredLists[index];
                      final listName = list['listname'];
                      final bookRefs = list['books'];

                      return BooksListSection(
                        title: listName,
                        bookRefs: bookRefs,
                        databaseService: databaseService,
                        backgroundColor: const Color(0xffFFFAF5),
                      );
                    },
                  );
                }

                return const Center(child: Text('No lists found!'));
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
  final List<dynamic> bookRefs;
  final DatabaseService databaseService;
  final Color backgroundColor;

  BooksListSection({
    required this.title,
    required this.bookRefs,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BooksListPage(
                    title: title,
                    bookRefs: bookRefs,
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
                  const SizedBox(height: 4),
                  Container(
                    height: 2,
                    width: 230,
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
              stream: databaseService.getBooksStream(bookRefs),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
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
                      final rating = book['rate'];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailPage(
                                title: title,
                                coverUrl: coverUrl,
                                summary: summary,
                                author: author,
                                rating: rating.toString(),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(12.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                coverUrl,
                                width: 100,
                                height: 130,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                return const Center(child: Text('No books found!'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
