import 'package:flutter/material.dart';
import 'package:activity_4_flutter/model/userdata.dart';
import 'package:activity_4_flutter/widgets/post_widget.dart';

class Postlist extends StatelessWidget {
  const Postlist({super.key, required this.userdata});

  final Userdata userdata;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: userdata.userList.map((userPost) {
        return PostWidget(userPost: userPost);
      }).toList(),
    );
  }
}
