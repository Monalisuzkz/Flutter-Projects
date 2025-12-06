import 'package:flutter/material.dart';
import 'package:flutter_application_razo/model/userdata.dart';

class InfoHeader extends StatelessWidget {
  final UserData userData;
  final VoidCallback onPostButtonPressed; // Accept the callback function

  const InfoHeader({
    super.key,
    required this.userData,
    required this.onPostButtonPressed, // Receive it in the constructor
  });

static const TextStyle followTxtStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Followers'),
            Text('Posts'),
            Text('Following'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              userData.myUserAccount.numFollowers,
              style: followTxtStyle,
            ),
            Text(
              userData.myUserAccount.numPosts,
              style: followTxtStyle,
            ),
            Text(
              userData.myUserAccount.numFollowing,
              style: followTxtStyle,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Colors.grey,
        ),
        // Add the button to create a new post
      ],
    );
  }
}
