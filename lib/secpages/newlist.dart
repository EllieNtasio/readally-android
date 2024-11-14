import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewListPage extends StatefulWidget {
  @override
  _NewListPageState createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> listNames = [];
  String? selectedList;

  @override
  void initState() {
    super.initState();
    _fetchListNames();
  }

  // Fetching the list names dynamically from Firestore
  Future<void> _fetchListNames() async {
    try {
      var snapshot = await _firestore.collection('lists').get();
      List<String> names = [];
      for (var doc in snapshot.docs) {
        names.add(doc['listname']);
      }
      setState(() {
        listNames = names;
      });
    } catch (e) {
      print('Error fetching list names: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lists'),
        backgroundColor: const Color(0xFFFFFAF5),
      ),
      body: Container(
        color: const Color(0xFFFFFAF5),
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
          children: [
            // Title for the section
            Text(
              'Existing Book Lists',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff001910),
              ),
            ),
            const SizedBox(height: 16),
            // Displaying the list items fetched from Firestore with space between containers
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xffFFFAF5),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align list to left
                children: listNames.map((listName) {
                  // Adding space between each list container
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0), // Add space between items
                    child: _ListItem(
                      listName: listName,
                      onTap: () {
                        print('Tapped on $listName');
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
            // Actions at the bottom, centered
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Push actions to the bottom
                crossAxisAlignment: CrossAxisAlignment.center, // Center them horizontally
                children: [
                  GestureDetector(
                    onTap: () {
                      _showCreateListDialog(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
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
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      _showDeleteListDialog(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Delete a List',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }

  // Show a dialog to create a new list
  void _showCreateListDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Create a List',
            style: TextStyle(
              color: Color(0xff001910),
            ),
          ),
          content: TextField(
            controller: _controller,
            style: TextStyle(color: Colors.grey.shade700),
            decoration: InputDecoration(
              hintText: "List Name",
              hintStyle: TextStyle(color: Colors.grey.shade400),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green.shade700),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green.shade300),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                String listName = _controller.text.trim();
                if (listName.isNotEmpty) {
                  _addNewListToFirestore(listName);
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Create',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Adding new list to Firestore
  Future<void> _addNewListToFirestore(String listName) async {
    try {
      await _firestore.collection('lists').add({
        'listname': listName,
        'books': [],
        'createdAt': Timestamp.now(),
      });
      print('New list created: $listName');
      _fetchListNames(); // Refresh the list of names after adding
    } catch (e) {
      print('Error creating list: $e');
    }
  }

  // Show a dialog to delete a list
  void _showDeleteListDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Choose a List to Delete',
            style: TextStyle(
              color: Color(0xff001910),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedList,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedList = newValue;
                  });
                },
                hint: const Text('Select List'),
                items: listNames.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (selectedList != null) {
                  _deleteListFromFirestore(selectedList!);
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Delete the selected list from Firestore
  Future<void> _deleteListFromFirestore(String listName) async {
    try {
      var snapshot = await _firestore
          .collection('lists')
          .where('listname', isEqualTo: listName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.delete();
        print('List deleted: $listName');
        _fetchListNames(); // Refresh list after deletion
      } else {
        print('No list found with the name: $listName');
      }
    } catch (e) {
      print('Error deleting list: $e');
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
        width: 300, // Set a fixed width for the containers
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.green.shade200,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          listName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Color(0xff001910),
          ),
        ),
      ),
    );
  }
}
