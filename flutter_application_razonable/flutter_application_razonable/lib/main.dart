import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'socialmedia.dart'; // Your main SocialMedia widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(); // Initialize Firebase
    debugPrint('Firebase initialized successfully');
    runApp(MyApp());
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
 // In case there's an issue with Firebase initialization
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social Media',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SocialMedia(), // Your main SocialMedia widget
    );
  }
}
