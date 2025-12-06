import 'package:activity_6_flutter/auth.dart';
import 'package:activity_6_flutter/googlesignin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final CollectionReference notes = FirebaseFirestore.instance.collection(
    'notes',
  );

  Future<void> _signOut() async {
    await AuthService().signOut();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => GoogleSignInPage()), 
    (route) => false,
    );
  }

  // inserting data
  Future<void> addNote(String title, String description) {
    return notes.add({
      'title': title,
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // update data
  Future<void> updateNote(String id, String title, String description) {
    return notes.doc(id).update({
      'title': title,
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // deleting data
  Future<void> deleteNote(String id) {
    return notes.doc(id).delete();
  }

  // search data
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool _isSearching = false;

  void _showNoteDialog({String? id, String? oldTitle, String? oldDesc}) {
    final titleController = TextEditingController(text: oldTitle ?? "");
    final descController = TextEditingController(text: oldDesc ?? "");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(id == null ? "Add Note" : "Edit Note"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text(id == null ? "Add" : "Update"),
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  descController.text.isNotEmpty) {
                if (id == null) {
                  addNote(titleController.text, descController.text);
                } else {
                  updateNote(id, titleController.text, descController.text);
                }
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return "";
    final date = timestamp.toDate();
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} "
        "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !_isSearching
            ? const Text('Notes App', style: TextStyle(color: Colors.white))
            : TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                decoration: const InputDecoration(
                  hintText: "Search notes...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _searchQuery = "";
                }
              });
            },
          ),
          IconButton( onPressed: _signOut, icon: Icon(Icons.logout, color: Colors.white),
           ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNoteDialog(),
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/flower_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: notes.orderBy("timestamp", descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Error on Notes"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!;
            if (data.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No Notes Yet. Add one!",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            // filter notes
            final filteredDocs = data.docs.where((doc) {
              final note = doc.data() as Map<String, dynamic>;
              final title = (note["title"] ?? "").toString().toLowerCase();
              final desc = (note["description"] ?? "").toString().toLowerCase();
              return title.contains(_searchQuery) ||
                  desc.contains(_searchQuery);
            }).toList();

            return ListView(
              padding: const EdgeInsets.all(10),
              children: filteredDocs.map((doc) {
                final note = doc.data() as Map<String, dynamic>;
                return Card(
                  elevation: 5,
                  color: Colors.pink[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    title: Text(
                      note["title"] ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                    subtitle: Text(
                      "${note["description"] ?? ""}\n${formatTimestamp(note["timestamp"])}",
                      style: const TextStyle(color: Colors.black87),
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.pink),
                          onPressed: () => _showNoteDialog(
                            id: doc.id,
                            oldTitle: note["title"],
                            oldDesc: note["description"],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteNote(doc.id),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
