import 'package:flutter/material.dart';
import 'package:activity_4_flutter/model/userpost.dart';
import 'package:activity_4_flutter/views/profile.view.dart';

class PostWidget extends StatefulWidget {
  final Userpost userPost;

  const PostWidget({super.key, required this.userPost});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final nametxtStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  gotoPage(BuildContext context, dynamic page) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userPost = widget.userPost;

    return InkWell(
      onTap: () => gotoPage(context, ProfileView(userPost: userPost)),
      child: Column(
        children: [
          // header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(userPost.userimg),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userPost.username, style: nametxtStyle),
                  Row(
                    children: [
                      Text('${userPost.time} · '),
                      const Icon(Icons.people, size: 18),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // content
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              children: [Text(userPost.postcontent, style: nametxtStyle)],
            ),
          ),

          // image
          if (userPost.postimg.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(userPost.postimg),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

          // counts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 👍 likes count
              Row(
                children: [
                  const Icon(Icons.thumb_up, size: 16, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text('${userPost.numlikes} Likes'),
                ],
              ),

              // 💬 comments + 🔄 shares
              Row(
                children: [
                  Text('${userPost.numcomments} Comments'),
                  const SizedBox(width: 20),
                  Text('${userPost.numshare} Shares'),
                ],
              ),
            ],
          ),



          const Divider(),

          // buttons
      Row(
  children: [
    Expanded(
      child: TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: userPost.isLiked ? Colors.blue : Colors.grey,
        ),
        onPressed: () {
          setState(() {
            userPost.isLiked = !userPost.isLiked;
            if (userPost.isLiked) {
              userPost.numlikes++;
            } else {
              userPost.numlikes--;
            }
          });
        },
        icon: Icon(
          Icons.thumb_up,
          color: userPost.isLiked ? Colors.blue : Colors.grey,
        ),
        label: Text(userPost.isLiked ? 'Liked' : 'Like'),
      ),
    ),
    Expanded(
      child: TextButton.icon(
        style: TextButton.styleFrom(foregroundColor: Colors.grey),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileView(
                userPost: userPost,
                autoFocusComment: true,
              ),
            ),
          );
        },
        icon: const Icon(Icons.chat_bubble),
        label: const Text('Comment'),
      ),
    ),
    Expanded(
      child: TextButton.icon(
        style: TextButton.styleFrom(foregroundColor: Colors.grey),
        onPressed: () {
          setState(() {
            userPost.numshare++;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Post Shared!")),
          );
        },
        icon: const Icon(Icons.share),
        label: const Text('Share'),
      ),
    ),
  ],
),


          SizedBox(height: 10, child: Container(color: Colors.grey)),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
