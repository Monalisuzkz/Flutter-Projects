import 'package:flutter/material.dart';
import 'package:flutter_application_razo/model/userdata.dart';
import '../model/friend.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key, required this.userData});

  final UserData userData;

  final TextStyle followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  Widget friend(Friend friend) => Card(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                friend.img,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(friend.name), // Display the friend's name
            ),
          ],
        ),
      );

  Widget friendsListGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 180,
      ),
      itemCount:
          userData.friendList.isNotEmpty ? userData.friendList.length : 0,
      itemBuilder: (BuildContext ctx, int index) {
        return friend(userData.friendList[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Text(
                'Friends',
                style: followTxtStyle,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Text('${userData.myUserAccount.numFriends} Friends'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 380,
          child: friendsListGrid(context),
        ),
        const SizedBox(
          height: 10,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
