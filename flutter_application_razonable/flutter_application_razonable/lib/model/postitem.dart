import 'package:flutter/material.dart';
import 'package:flutter_application_razo/model/userpost.dart';

class PostItem extends StatelessWidget {
  final UserPost post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display user image, name, and post time
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(post.userimg),
                ),
                const SizedBox(width: 8),
                Text(post.username,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(post.formattedTime, // Use formattedTime here
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            // Post content
            Text(post.postcontent),
            // If there's an image in the post, display it
            if (post.postimg.isNotEmpty) Image.asset(post.postimg),
            const SizedBox(height: 8),
            // Display comments and shares count
            Row(
              children: [
                Text('${post.numcomments} Comments'),
                const Spacer(),
                Text('${post.numshare} Shares'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
