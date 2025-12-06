import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_razo/model/usercomment.dart';

class UserPost {
  String id;
  String userimg;
  String username;
  Timestamp time; // Keep this as Timestamp
  String postcontent;
  String postimg;
  String numcomments;
  String numshare;
  bool isLiked;
  List<UserComment> comments;

  UserPost({
    required this.id,
    required this.userimg,
    required this.username,
    required this.time,
    required this.postcontent,
    required this.postimg,
    required this.numcomments,
    required this.numshare,
    required this.isLiked,
    this.comments = const [],
  });

  // Getter for time as a formatted string
  String get formattedTime {
    DateTime dateTime = time.toDate(); // Convert Timestamp to DateTime
    return "${dateTime.month}/${dateTime.day}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}"; // Format it to a string
  }

  // From JSON
  factory UserPost.fromJson(Map<String, dynamic> json, String id) {
    return UserPost(
        id: id,
      userimg: json['userimg'] as String? ?? '',
      username: json['username'] as String? ?? '',
      time: json['time'] as Timestamp? ?? Timestamp.now(),
      postcontent: json['postcontent'] as String? ?? '',
      postimg: json['postimg'] as String? ?? '',
      numcomments: json['numcomments'] as String? ?? '0',
      numshare: json['numshare'] as String? ?? '0',
      isLiked: json['isLiked'] as bool? ?? false,
      comments: (json['comments'] as List<dynamic>? ?? [])
          .map((comment) =>
              UserComment.fromJson(comment as Map<String, dynamic>))
          .toList(),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userimg': userimg,
      'username': username,
      'time': time,
      'postcontent': postcontent,
      'postimg': postimg,
      'numcomments': numcomments,
      'numshare': numshare,
      'isLiked': isLiked,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }

  
}
