import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final String title;
  final String coverUrl;
  final String summary;
  final String author;
  final String rating;

  BookDetailPage({
    required this.title,
    required this.coverUrl,
    required this.summary,
    required this.author,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    int parsedRating = int.tryParse(rating) ?? 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFAF5),
        title: Text(''),

      ),
      backgroundColor: Color(0xffFFFAF5),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 250,
            child: Image.asset(
              'assets/images/circles.png',
              width: 300,
              height: 300,
            ),
          ),
          Positioned(
            top: -35,
            right: 220,
            child: Image.asset(
              'assets/images/bb.png',
              width: 300,
              height: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      coverUrl,
                      width: 150,
                      height: 230,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    color: Color(0xff001910),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Author: $author',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 40),
                      Container(
                        height: 30,
                        width: 1,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xffffb700),
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 1.0),
                        child: Text(
                          'About this book:',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Inter',
                            color: Color(0xff001910),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Color(0xff385723),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                summary,
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}