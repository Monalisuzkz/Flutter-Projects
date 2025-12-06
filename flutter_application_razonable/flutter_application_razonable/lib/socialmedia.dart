import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_razo/model/usercomment.dart';
import 'package:flutter_application_razo/model/userpost.dart';
import 'package:flutter_application_razo/services/post_service.dart';
import 'package:flutter_application_razo/views/friendlist.dart';
import 'package:flutter_application_razo/views/infoheader.dart';
import 'package:flutter_application_razo/views/postlist.dart';
import 'package:flutter_application_razo/views/mainheader.dart';
import 'model/userdata.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  UserData userData = UserData();
  TextEditingController postController = TextEditingController();
  List<UserPost> posts = [];

  TextStyle followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  // Fetch posts from Firestore
void _fetchPosts() async {
    List<UserPost> fetchedPosts = await PostService().getPosts();
    debugPrint('Fetched posts: $fetchedPosts'); // Log the fetched posts
    setState(() {
      posts = fetchedPosts;
    });
  }


  @override
  void initState() {
    super.initState();
    _fetchPosts(); // Fetch posts when widget is first loaded
  }

  // Create a post
  void _postStatus() {
    String statusContent = postController.text.trim();
    if (statusContent.isNotEmpty) {
      UserPost newPost = UserPost(
        id: '', // Firebase will generate an ID
        userimg: 'assets/me.jpg',
        username: userData.myUserAccount.name,
        time: Timestamp.now(),
        postcontent: statusContent,
        postimg: '',
        numcomments: '0 comments',
        numshare: '0 shares',
        isLiked: false,
        comments: [],
      );
      PostService().createPost(newPost); // Create post in Firestore
      postController.clear();
      _fetchPosts(); // Fetch updated posts list
    }
  }

  // Update post
  void _updatePost(UserPost post) {
    post.postcontent = 'Updated content'; // Example of post update
    PostService().updatePost(post.id, post); // Update post in Firestore
    _fetchPosts(); // Fetch updated posts list
  }

  // Delete post
  void _deletePost(UserPost post) {
    PostService().deletePost(post.id); // Delete post from Firestore
    _fetchPosts(); // Fetch updated posts list
  }

  // Show comment dialog to add a comment to a post
  void _showCommentDialog(UserPost post) {
    TextEditingController commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a Comment'),
          content: TextField(
            controller: commentController,
            decoration: const InputDecoration(hintText: 'Type your comment'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  post.comments.add(UserComment(
                    commenterImg: 'assets/me.jpg',
                    commenterName: userData.myUserAccount.name,
                    commentTime: 'Just now',
                    commentContent: commentController.text,
                  ));
                });
                Navigator.pop(context);
              },
              child: const Text('Post Comment'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          MainHeader(userData: userData),
          InfoHeader(userData: userData, onPostButtonPressed: _postStatus),
          FriendList(userData: userData),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextField(
              controller: postController,
              decoration: const InputDecoration(
                labelText: "What's on your mind?",
                border: OutlineInputBorder(),
                hintText: 'Write something...',
              ),
              maxLines: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ElevatedButton(
              onPressed: _postStatus,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Add Post'),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Text(
                  'Posts',
                  style: followTxtStyle, // Apply the defined TextStyle
                ),
              ],
            ),
          ),
          PostsList(
            userData: userData,
            posts: posts, // Pass the posts list here
            onCommentButtonPressed: _showCommentDialog,
            onEditButtonPressed: _updatePost,
            onDeleteButtonPressed: _deletePost,
          ),
        ],
      ),
    );
  }
}
