import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewListPage extends StatelessWidget {
  // Reference to Firestore collection to save the new list
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lists'), // Title of your app bar
        backgroundColor: const Color(0xFFFFFAF5), // AppBar background color
      ),
      body: Container(
        color: const Color(0xFFFFFAF5), // Background color for the body (light gray)
        padding: const EdgeInsets.all(25.0), // Add padding for the entire body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align column children to the left
          children: [
            // Heading or Section Title (Left aligned)
            Text(
              'Existing Book Lists',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff001910),
              ),
            ),
            const SizedBox(height: 16),

            // Container to display the names of the lists
            Container(
              padding: const EdgeInsets.all(0.0), // Padding for the larger container
              decoration: BoxDecoration(
                color: Color(0xffFFFAF5), // Light background color
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Left-aligning the list items
                children: [
                  // List of existing lists (only names)
                  _ListItem(
                    listName: 'Stephen King Books',
                    onTap: () {
                      // Action for "Stephen King Books"
                      print('Tapped on Stephen King Books');
                    },
                  ),
                  const SizedBox(height: 12),
                  _ListItem(
                    listName: 'Academic Books',
                    onTap: () {
                      // Action for "Academic Books"
                      print('Tapped on Academic Books');
                    },
                  ),
                  const SizedBox(height: 12),
                  _ListItem(
                    listName: 'Best Sellers',
                    onTap: () {
                      // Action for "Best Sellers"
                      print('Tapped on Best Sellers');
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Create a New List Text with an Icon
            GestureDetector(
              onTap: () {
                // Open the dialog to create a new list
                _showCreateListDialog(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.green,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Create a New List',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show the dialog for creating a new list
  void _showCreateListDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter List Name'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "List Name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the new list to Firestore
                String listName = _controller.text.trim();
                if (listName.isNotEmpty) {
                  _addNewListToFirestore(listName);
                  Navigator.pop(context); // Close the dialog
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  // Method to add the new list to Firestore
  Future<void> _addNewListToFirestore(String listName) async {
    try {
      // Add the new list to the "lists" collection in Firestore
      await _firestore.collection('lists').add({
        'name': listName,
        'createdAt': Timestamp.now(),
      });

      // You can also update the state or show a success message if needed
      print('New list created: $listName');
    } catch (e) {
      print('Error creating list: $e');
    }
  }
}

// Widget to display individual list item (only name)
class _ListItem extends StatelessWidget {
  final String listName;
  final VoidCallback onTap;

  const _ListItem({
    required this.listName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.green.shade200, // Lighter green background for each list item
          borderRadius: BorderRadius.circular(10.0), // Rounded corners for list items
        ),
        child: Text(
          listName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Color(0xff001910), // Dark text color
          ),
        ),
      ),
    );
  }
}
