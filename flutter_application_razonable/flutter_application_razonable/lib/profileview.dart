import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_razo/model/userpost.dart';
import 'package:flutter_application_razo/model/usercomment.dart';
import 'package:intl/intl.dart';

class _ProfileView extends StatefulWidget {
  const _ProfileView({required this.userPost});

  final UserPost userPost;

  @override
  _ProfileViewState createState() => _ProfileViewState();
}


class _ProfileViewState extends State<_ProfileView> {
  final TextEditingController _commentController =
      TextEditingController(); // Controller for comment input
  final List<UserComment> _comments = []; // List to store comments

  // Variable to hold the updated comment count
  int _numComments = 0;

  // Function to format the timestamp
  String _formatTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('yyyy-MM-dd – kk:mm')
        .format(dateTime); // Format the date as needed
  }

  // Widget to display user information
  Widget userLine(UserPost userPost) {
    String formattedTime = _formatTime(userPost.time); // Format the time

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(userPost.userimg),
      ),
      title: Text(userPost.username,
          style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(formattedTime), // Display the formatted time
    );
  }

  // Widget to display the text content of the post
  Widget postTextWidget() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.userPost.postcontent),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for post action buttons like like, comment, and share
  Widget buttons(UserPost userPost) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.thumb_up),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.comment),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share),
        ),
      ],
    );
  }

  // Widget to display the list of comments
  Widget commentList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _comments.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(_comments[index].commenterImg),
          ),
          title: Text(_comments[index].commenterName),
          subtitle: Text(_comments[index].commentContent),
        );
      },
    );
  }

  // Function to add a comment and update the comment count
  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        // Add the new comment to the list
        _comments.add(
          UserComment(
            commenterImg: 'assets/me.jpg', // Assuming the user image
            commenterName:
                'Juliana Gwyneth Razonable', // Replace with actual username
            commentTime: 'Just now',
            commentContent: _commentController.text,
          ),
        );

        // Update the local comment count
        _numComments++;

        // Clear the comment input after posting
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
        ),
      ),
      body: ListView(
        children: [
          userLine(widget.userPost),
          postTextWidget(),
          // Display the current number of comments
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$_numComments comments'), // Use the updated count
          ),
          buttons(widget.userPost),
          const Divider(), // Divider between the post and comments section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text('Comments', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          // Display the list of comments
          commentList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _addComment,
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
