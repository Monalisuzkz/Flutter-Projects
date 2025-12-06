import 'package:flutter/material.dart';
import 'package:flutter_application_razo/model/userdata.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    super.key,
    required this.userData,
  });

  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            userData.myUserAccount.img,
          ), // AssetImage
          radius: 40,
        ), // CircleAvatar
        Text(
          userData.myUserAccount.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ), // TextStyle
        ), // Text
        Text(
          userData.myUserAccount.email,
        ), // Text
        const SizedBox(
          height: 20,
        ), // SizedBox
      ],
    ); // Column
  }
}
