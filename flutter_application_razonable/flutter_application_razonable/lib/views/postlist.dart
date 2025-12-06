import 'package:flutter/material.dart';
import 'package:flutter_application_razo/model/userdata.dart';
import 'package:flutter_application_razo/model/userpost.dart';

class PostsList extends StatelessWidget {
  final UserData userData;
  final List<UserPost> posts; // Add posts parameter
  final Function(UserPost) onCommentButtonPressed;
  final Function(UserPost) onEditButtonPressed;
  final Function(UserPost) onDeleteButtonPressed;

  const PostsList({
    super.key,
    required this.userData,
    required this.posts, // Accept posts as parameter
    required this.onCommentButtonPressed,
    required this.onEditButtonPressed,
    required this.onDeleteButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: posts.length, // Use posts list length
      itemBuilder: (BuildContext ctx, int index) {
        UserPost post = posts[index]; // Use the posts list
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(post.userimg),
                ),
                title: Text(post.username),
                subtitle: Text(
                    post.formattedTime), // Displaying the formatted timestamp
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => onEditButtonPressed(post),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => onDeleteButtonPressed(post),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(post.postcontent),
              ),
              post.postimg.isNotEmpty
                  ? Image.asset(post.postimg)
                  : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        post.isLiked
                            ? Icons.thumb_up
                            : Icons.thumb_up_alt_outlined,
                        color: post.isLiked ? Colors.blue : null,
                      ),
                      onPressed: () {
                        // Handle like/unlike action
                      },
                    ),
                    Text(post.numcomments),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () => onCommentButtonPressed(post),
                    ),
                    Text(post.numshare),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: post.comments.length,
                itemBuilder: (ctx, idx) {
                  var comment = post.comments[idx];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(comment.commenterImg),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(comment.commenterName),
                            Text(comment.commentTime),
                            Text(comment.commentContent),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
