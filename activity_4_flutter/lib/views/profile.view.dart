import 'package:activity_4_flutter/model/usercomment.dart';
import 'package:activity_4_flutter/model/userdata.dart';
import 'package:activity_4_flutter/model/userpost.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  final Userpost userPost;
  final bool autoFocusComment;

  const ProfileView({
    super.key,
    required this.userPost,
    this.autoFocusComment = false,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final Userdata userData = Userdata();
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocus = FocusNode();

  final nametxtStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final boldtxtStyle = const TextStyle(fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    if (widget.autoFocusComment) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          FocusScope.of(context).requestFocus(_commentFocus);
        }
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocus.dispose();
    super.dispose();
  }

  Widget userline(Userpost userPost) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              backgroundImage: AssetImage(userPost.userimg),
              radius: 20,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userPost.username, style: nametxtStyle),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(userPost.time),
                  const Text('.'),
                  const Icon(Icons.group, size: 15, color: Colors.grey),
                ],
              ),
            ],
          ),
        ],
      );

  Widget postimage(Userpost userPost) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(children: [Text(userPost.postcontent)]),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                userPost.postimg,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      );

  /// 👇 Combined likes + comments row
  Widget postStats(Userpost userPost) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${userPost.numlikes} Likes", style: boldtxtStyle),
            Text("${userPost.numcomments} Comments", style: boldtxtStyle),
          ],
        ),
      );

  Widget buttons(Userpost userPost) => Column(
  children: [
    const Divider(color: Colors.grey),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: userPost.isLiked ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                if (userPost.isLiked) {
                  userPost.isLiked = false;
                  userPost.numlikes--;
                } else {
                  userPost.isLiked = true;
                  userPost.numlikes++;
                }
              });
            },
            icon: Icon(
              Icons.thumb_up,
              size: 20,
              color: userPost.isLiked ? Colors.blue : Colors.grey,
            ),
            label: Text(
              userPost.isLiked ? 'Liked' : 'Like',
            ),
          ),
          TextButton.icon(
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
            icon: const Icon(Icons.comment, size: 20),
            label: const Text('Comment'),
          ),
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.grey),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post shared!')),
              );
            },
            icon: const Icon(Icons.share, size: 20),
            label: const Text('Share'),
          ),
        ],
      ),
    )
  ],
);


  Widget _commentTile(Usercomment c) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(backgroundImage: AssetImage(c.commentImg), radius: 18),
          const SizedBox(width: 10),
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 250, // 👈 set max width so it doesn’t get too wide
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(35, 158, 158, 158),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.commentName, style: boldtxtStyle),
                    const SizedBox(height: 4),
                    Text(c.commentContent),
                    const SizedBox(height: 6),
                    Text(
                      c.commenterTime,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );


  @override
  Widget build(BuildContext context) {
    final userPost = widget.userPost;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                userline(userPost),
                postimage(userPost),
                postStats(userPost), 
                buttons(userPost),
                const Divider(color: Colors.grey),
                ...userData.commentList.map(_commentTile),
                const SizedBox(height: 70),
              ],
            ),
          ),

          // comment input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _commentFocus,
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: "Write a comment...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = _commentController.text.trim();
                    if (text.isNotEmpty) {
                      setState(() {
                        userData.commentList.add(
                          Usercomment(
                            commentImg: userData.myUserAccount.img,
                            commentName: userData.myUserAccount.name,
                            commenterTime: "Just now",
                            commentContent: text,
                          ),
                        );
                        userPost.numcomments++;
                        _commentController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
