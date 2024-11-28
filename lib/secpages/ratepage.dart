import 'package:flutter/material.dart';
import 'package:readally/database.dart';  // Import your DatabaseService
import 'package:cloud_firestore/cloud_firestore.dart';

class RatePage extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();

  RatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating Page'),
        backgroundColor: const Color(0xffFFFAF5),
      ),
      backgroundColor: const Color(0xffFFFAF5),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Ratings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF385723),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Changed your mind? Tap to change it!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xffF385723),
                      ),
                    ),
                  ],
                ),
              ],
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
                  final lists = snapshot.data!.where((list) {

                    return list['books'] != null && (list['books'] as List).isNotEmpty;
                  }).toList();

                  if (lists.isEmpty) {
                    return const Center(child: Text('No lists with books available'));
                  }

                  return ListView.builder(
                    itemCount: lists.length,
                    itemBuilder: (context, index) {
                      final list = lists[index];
                      final listName = list['listname'];
                      final bookRefs = list['books'];

                      return RateListSection(
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

class RateListSection extends StatelessWidget {
  final String title;
  final List<dynamic> bookRefs;
  final DatabaseService databaseService;
  final Color backgroundColor;

  RateListSection({
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff001910),
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
                      final coverUrl = book['cover'];
                      final rating = book['rate'];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(12.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: GestureDetector(
                              onTap: () {

                                _showRatingDialog(context, book, databaseService);
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 130,
                                    child: Image.network(
                                      coverUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.error);
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 30,
                                    color: const Color(0xFF385723),
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 18,
                                        ),
                                        Text(
                                          rating.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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

  // Method to show the rating dialog and allow the user to change the rating
  void _showRatingDialog(BuildContext context, Map<String, dynamic> book, DatabaseService databaseService) {
    final TextEditingController ratingController = TextEditingController(text: book['rate'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Rating for ${book['title']}'),
          content: TextField(
            controller: ratingController,
            decoration: InputDecoration(hintText: "Enter new rating"),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                final newRating = ratingController.text;

                if (newRating.isNotEmpty) {
                  final double parsedRating = double.tryParse(newRating) ?? 0.0;


                  databaseService.updateBookRating(book['id'], parsedRating.toString());


                  Navigator.of(context).pop();
                }
              },

              child: Text('Update Rating',style: TextStyle(color: Colors.green)),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel',style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }
}

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Stream<List<Map<String, dynamic>>> getBooksStream(List<dynamic> bookRefs) {
    return _db.collection('books')
        .where(FieldPath.documentId, whereIn: bookRefs)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        'title': doc['title'],
        'cover': doc['cover'],
        'rate': doc['rate'],
      };
    }).toList());
  }


  Stream<List<Map<String, dynamic>>> getListsStream() {
    return _db.collection('lists')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      return {
        'listname': doc['listname'],
        'books': List.from(doc['books']),
      };
    }).toList());
  }

  // Method to update the book rating
  Future<void> updateBookRating(String bookId, String newRating) async {
    try {
      await _db.collection('books').doc(bookId).update({
        'rate': newRating,
      });
    } catch (e) {
      print('Error updating rating: $e');
    }
  }
}
