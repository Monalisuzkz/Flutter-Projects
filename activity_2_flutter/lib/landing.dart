import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final String username;
  final String password;

  const LandingPage({super.key, required this.username, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Razonable Task 2"),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("user: $username", style: const TextStyle(fontSize: 30)),
            SizedBox(height: 30),
            Text("password: $password", style: const TextStyle(fontSize: 30)),
            SizedBox(height: 30),

            ElevatedButton(onPressed: () => Navigator.pop(context),
            child: Text("BACK TO LOGIN",
              ),
              ),
          ],
          ),
        ),
      );
  }
}
