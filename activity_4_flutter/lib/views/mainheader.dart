import 'package:activity_4_flutter/model/userdata.dart';
import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key, required this.userdata});
  
  final Userdata userdata;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(userdata.myUserAccount.img),
          radius: 40,
        ),
        Text(
          userdata.myUserAccount.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        Text(userdata.myUserAccount.email),
        const SizedBox(height: 20),

      ],
    );
  }
}