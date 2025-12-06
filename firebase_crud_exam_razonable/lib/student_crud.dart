// lib/student_crud.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentCrudApp extends StatefulWidget {
  const StudentCrudApp({super.key});

  @override
  State<StudentCrudApp> createState() => _StudentCrudAppState();
}

class _StudentCrudAppState extends State<StudentCrudApp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  final CollectionReference _studentsRef =
      FirebaseFirestore.instance.collection('students');

  bool _isAdding = false;

  @override
  void dispose() {
    _nameController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  Future<void> _addStudent() async {
    final name = _nameController.text.trim();
    final course = _courseController.text.trim();

    if (name.isEmpty || course.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both name and course')),
      );
      return;
    }

    setState(() => _isAdding = true);
    try {
      await _studentsRef.add({
        'name': name,
        'course': course,
        'createdAt': FieldValue.serverTimestamp(),
      });
      _nameController.clear();
      _courseController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student added')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add student: $e')),
      );
    } finally {
      setState(() => _isAdding = false);
    }
  }

  Future<void> _deleteStudent(String docId) async {
    try {
      await _studentsRef.doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Delete failed: $e')),
      );
    }
  }

  Future<void> _updateStudent(String docId, String currentName, String currentCourse) async {
    final TextEditingController nameEdit = TextEditingController(text: currentName);
    final TextEditingController courseEdit = TextEditingController(text: currentCourse);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameEdit, decoration: const InputDecoration(labelText: 'Name')),
              const SizedBox(height: 8),
              TextField(controller: courseEdit, decoration: const InputDecoration(labelText: 'Course')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final updatedName = nameEdit.text.trim();
                final updatedCourse = courseEdit.text.trim();
                if (updatedName.isEmpty || updatedCourse.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please provide name and course')),
                  );
                  return;
                }
                try {
                  await _studentsRef.doc(docId).update({
                    'name': updatedName,
                    'course': updatedCourse,
                    'updatedAt': FieldValue.serverTimestamp(),
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Student updated')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Update failed: $e')),
                  );
                } finally {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAllStudents() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete all students?'),
        content: const Text('This will permanently remove all student records.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Delete All')),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final snapshot = await _studentsRef.get();
      final batch = FirebaseFirestore.instance.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All students deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete all students: $e')),
      );
    }
  }

  Widget _buildAddSection() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Name', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(controller: _nameController, decoration: const InputDecoration(hintText: 'Enter student name')),
            const SizedBox(height: 12),
            const Text('Course', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(controller: _courseController, decoration: const InputDecoration(hintText: 'Enter course')),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isAdding ? null : _addStudent,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: _isAdding
                    ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Add Student'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentCard(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final name = data['name'] ?? 'No Name';
    final course = data['course'] ?? '';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(course),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: () => _updateStudent(doc.id, name, course)),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete student?'),
                    content: Text('Delete "$name"?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
                      ElevatedButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Delete')),
                    ],
                  ),
                );
                if (confirm == true) _deleteStudent(doc.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentList() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _studentsRef.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text('No students yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: docs.length,
            itemBuilder: (context, index) => _buildStudentCard(docs[index]),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.98),
      appBar: AppBar(
        title: const Text('Student Records'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              print('Logout clicked');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout clicked')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildAddSection(),
            _buildStudentList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _deleteAllStudents,
        tooltip: 'Clear all students',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
