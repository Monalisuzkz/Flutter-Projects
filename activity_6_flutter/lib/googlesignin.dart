import 'package:activity_6_flutter/auth.dart';
import 'package:activity_6_flutter/notes_page.dart';
import 'package:flutter/material.dart';

class GoogleSignInPage extends StatefulWidget {
  const GoogleSignInPage({super.key});

  @override
  State<GoogleSignInPage> createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {

  String _status = "Not Signed IN";

  void _handleSignIn() async {
    final user = await AuthService().signInWithGoogle();
    if(user != null){
      if(!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NotesPage()),
      );
    }else{
      setState(() {
        _status = "Signed in failed!";
      });
    }
  }

  void _handleSignOut() async {
    await AuthService().signOut();
    setState(() {
      _status = "Signed out";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task 8 Razonable"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _handleSignIn,
             child: Text("Signed in with Google!"),
             ),
             const SizedBox(height: 10),
             ElevatedButton(onPressed: _handleSignOut, child: Text("Sign Out"),
             ),
          ],
        ),
      ),
    );
  }
}