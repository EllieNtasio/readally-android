import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readally/components/card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  List<Map<String, dynamic>> searchResults = [];

  void searchBooks(String query) async {
    if (query.isNotEmpty) {
      final titleResults = await FirebaseFirestore.instance
          .collection('books')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      final authorResults = await FirebaseFirestore.instance
          .collection('books')
          .where('author', isGreaterThanOrEqualTo: query)
          .where('author', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      final combinedResults = {
        ...titleResults.docs.map((doc) => {'id': doc.id, ...doc.data()}),
        ...authorResults.docs.map((doc) => {'id': doc.id, ...doc.data()}),
      };

      setState(() {
        searchResults = combinedResults.map((result) => result as Map<String, dynamic>).toList();
      });
    } else {
      setState(() {
        searchResults = [];
      });
    }
  }

  void showMoveToListDialog(BuildContext context, String bookId, String bookTitle) async {
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
                    const Icon(Icons.search, color: Color(0xff385723)),
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
                final title = book['title'] ?? 'No Title';
                final coverUrl = book['cover'] ?? '';
                final summary = book['summ'] ?? 'No summary available';
                final author = book['author'] ?? 'Unknown Author';
                final rating = book['rate'] ?? '0';
                final bookId = book['id'];

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
                          rating: rating,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            coverUrl,
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
                                title,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff001910),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                author,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
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
