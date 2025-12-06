import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../model/userpost.dart';

class PostService {
  final FirebaseFirestore _db = FirebaseFirestore.instance; // Firebase instance
  final String postsCollection = 'posts'; // Firestore collection name for posts

  // Fetch all posts (order by time descending)
  Future<List<UserPost>> getPosts() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection(postsCollection)
          .orderBy('time', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return UserPost.fromJson(doc.data() as Map<String, dynamic>,
            doc.id); // Pass doc.id as postId
      }).toList();
    } catch (e) {
      debugPrint('Error fetching posts: $e'); 
      return [];
    }
  }

Future<void> createPost(UserPost post) async {
    debugPrint('Attempting to add post...');
    try {
      final postData = {
        'username': post.username,
        'userimg': post.userimg,
        'time': post.time,
        'postcontent': post.postcontent,
        'postimg': post.postimg,
        'numcomments': post.numcomments,
        'numshare': post.numshare,
        'isLiked': post.isLiked,
        'comments': post.comments.isNotEmpty
            ? post.comments.map((comment) => comment.toJson()).toList()
            : [],
      };

      await FirebaseFirestore.instance.collection('posts').add(postData);
      debugPrint('Post added successfully');
    } catch (e) {
      debugPrint('Error creating post: $e');
    }
  }



  // Update an existing post
  Future<void> updatePost(String postId, UserPost post) async {
    try {
      await _db
          .collection(postsCollection)
          .doc(postId)
          .update(post.toJson()); // Update the post in Firestore
    } catch (e) {
      debugPrint('Error updating post: $e');
    }
  }

  // Delete a post
  Future<void> deletePost(String postId) async {
    try {
      await _db
          .collection(postsCollection)
          .doc(postId)
          .delete(); // Delete the post from Firestore
    } catch (e) {
      debugPrint('Error deleting post: $e');
    }
  }
}
