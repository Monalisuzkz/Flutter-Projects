import 'package:activity_4_flutter/model/userdata.dart';
import 'package:flutter/material.dart';

class Infoheader extends StatelessWidget {
  const Infoheader({super.key, required this.userdata});

  final Userdata userdata;

  final followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );


@override
Widget build(BuildContext context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text('Followers'),
              Text(userdata.myUserAccount.numFollowers, style: followTxtStyle),
            ],
          ),
          Column(
            children: [
              const Text('Following'),
              Text(userdata.myUserAccount.numFollowing, style: followTxtStyle),
            ],
          ),
          Column(
            children: [
              const Text('Post'),
              Text(userdata.myUserAccount.numPosts, style: followTxtStyle),
            ],
          ),
        ],
      ),
      const SizedBox(height: 10),
      const Divider(color: Colors.grey),
    ],
  );
}
}