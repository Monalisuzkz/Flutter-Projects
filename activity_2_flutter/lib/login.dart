import 'package:activity_2_flutter/landing.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(){
    String username = _usernameController.text;
    String password = _passwordController.text;

    Navigator.push(context,
    MaterialPageRoute(builder: (context) => LandingPage(
      username: username,
      password: password,
         ),
        ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page '),
      ),
      body: Padding(padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: "Username",
              hintText: "Enter your username",
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              )
            ),
          ),
          const SizedBox(height: 15),
           TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              )
            ),
          ),
          const SizedBox(height: 25,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: _login,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Login',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
            ),
          )
        ],
      ),),
    );
  }
}