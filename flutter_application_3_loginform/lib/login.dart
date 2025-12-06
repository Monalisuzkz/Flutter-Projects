import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login ({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String errormessage;
  late bool isError;

  var txtstyle = TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontSize: 38,
  );

  var btnstyle = ElevatedButton.styleFrom(
    minimumSize: Size.fromHeight(50)
  );

  var errorTxtStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.red,
    letterSpacing: 1,
    fontSize: 18);

    checkLogin(username, password) {
      setState(() {
      if (username == "") {
        errormessage = "Please input your username";
        isError = true;
      }
      else  if (password == "") {
        errormessage = "Please input your password";
        isError = true;
      } else {
        errormessage = "";
        isError = false;
      }
      });
    }

  @override
  void initState() {
    errormessage = "This is an Error!";
    isError = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
             Text('SIGN UP', style: txtstyle),
             SizedBox(height: 15),
             TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter username:',
                prefixIcon: Icon(Icons.person),
                ),
             ),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter password:',
                prefixIcon: Icon(Icons.lock),
                ),
             ),
             SizedBox(height: 15),
             ElevatedButton(
              style: btnstyle,
              onPressed: (){
                checkLogin(usernameController.text, passwordController.text);
              }, 
              child: Text('LOGIN'),
             ),
             SizedBox(height: 15),
             (isError)
              ?Text(errormessage, style: errorTxtStyle)
              :Container(),
          ],
        ),
        ),
      ),
    );
  }
}