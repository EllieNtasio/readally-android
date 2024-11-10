import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final String title;
  final String coverUrl; // Cover image URL
  final String summary; // Book summary (from 'summ' field)
  final String author; // Author's name
  final String rating; // Rating as a string

  BookDetailPage({
    required this.title,
    required this.coverUrl,
    required this.summary,
    required this.author,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    // Parse the rating string to a number, with a fallback in case of error
    int parsedRating = int.tryParse(rating) ?? 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFAF5),
        title: Text(''),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert), // Three dots icon
            onPressed: () {
              // Define the action for the three dots (if needed)
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  height: 200,
                  child: Center(
                    child: Text('More options'),
                  ),
                ),
              );
            },
          ),
        ],
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
                // Book cover at the top
                Center(
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(10.0), // Set the radius for the corners
                    child: Image.network(
                      coverUrl,
                      width: 150, // Set width for the cover image
                      height: 230, // Set height for the cover image
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error); // Error handling for the image
                      },
                    ),
                  )

                ),
                const SizedBox(height: 16),
                // Book title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    color: Color(0xff001910), // Adjust text color
                  ),
                  textAlign: TextAlign.center, // Center align the title
                ),
                const SizedBox(height: 16),
                // Author name and rating
                Container(
                  padding: const EdgeInsets.all(10.0), // Add padding inside the container
                  decoration: BoxDecoration(
                    color: Colors.green[50], // Light green background color
                    borderRadius: BorderRadius.circular(12), // Border radius for rounded corners
                    border: Border.all(color: Colors.green), // Green border
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Author
                      Text(
                        'Author: $author',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54, // Adjust text color
                        ),
                      ),
                      const SizedBox(width: 40), // Space between the author and the line

                      // Green vertical line as a separator
                      Container(
                        height: 30, // Height of the divider
                        width: 1, // Width of the line
                        color: Colors.green, // Line color
                      ),
                      const SizedBox(width: 15), // Space between the line and the rating

                      // Rating with star icon
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xffffb700), // Star color
                            size: 20,
                          ),
                          const SizedBox(width: 4), // Spacing between star and rate
                          Text(
                            rating,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54, // Adjust text color
                            ),
                          ), // Display the numeric rate
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                // Book summary below the cover
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align items to the left
                    children: [
                      // Text above the summary section
                      const Padding(
                        padding: EdgeInsets.only(bottom: 1.0), // Add some space below the text
                        child: Text(
                          'About this book:',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Inter',// Bold text
                            color: Color(0xff001910), // Green color for the text
                          ),
                        ),
                      ),

                      // Green thin line (divider)
                      // Green thin line (divider) with shorter width



                      // Scrollable section for the summary
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0), // Add space above the summary
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Color(0xff385723), // Set the color of the vertical line
                                    width: 2.0, // Set the thickness of the line
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(10.0), // Padding inside the container
                              child: Text(
                                summary,
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.justify, // Adjust text alignment
                              ),
                            ),
                          ),
                        )

                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
