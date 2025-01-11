import 'package:flutter/material.dart';
import 'package:readally/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ARBooksPage extends StatelessWidget {
  const ARBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arbooks List'),
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
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff385723),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
                    width: 130,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
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


  void showMoveToListDialog(BuildContext context, String bookId, String bookTitle) async {
    // Fetch all lists from Firestore
    QuerySnapshot listsSnapshot = await FirebaseFirestore.instance.collection('lists').get();
    List<Map<String, dynamic>> availableLists = listsSnapshot.docs.map((doc) {
      return {
        'id': doc.id,
        'name': doc['listname'],
      };
    }).toList();


    availableLists = availableLists.where((list) => list['name'] != 'arbooks').toList();

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
                  DocumentReference listDoc = FirebaseFirestore.instance.collection('lists').doc(listInfo['id']);


                  await listDoc.update({
                    'books': FieldValue.arrayUnion([bookId]),
                  });


                  DocumentReference currentListDoc = FirebaseFirestore.instance.collection('lists').doc('F57etWoaNdSGYQ3RmTAo'); // "arbooks" list id
                  await currentListDoc.update({
                    'books': FieldValue.arrayRemove([bookId]),
                  });

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Moved "$bookTitle" to ${listInfo['name']}')),
                  );
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

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
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final coverUrl = book['cover'];
                final title = book['title'];
                final author = book['author'];
                final bookId = book['id'];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    children: [
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
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: Colors.grey),
                        onPressed: () {
                          showMoveToListDialog(context, bookId, title);
                        },
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
