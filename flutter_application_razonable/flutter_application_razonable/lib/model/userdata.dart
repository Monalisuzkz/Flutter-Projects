import 'package:cloud_firestore/cloud_firestore.dart';

import 'friend.dart';
import 'usercomment.dart';
import 'userpost.dart';
import 'account.dart';

class UserData {
  List<UserPost> userList = [
    UserPost(
      id: 'post1', // Unique ID for each post
      userimg: 'assets/Boy1.jpg',
      username: 'RebandSome Cliff',
      time: Timestamp.now(),
      postcontent: 'Time is Gold',
      postimg: 'assets/03.jpg',
      numcomments: '8.5k comments',
      numshare: '90 shares',
      isLiked: false,
      comments: [
        UserComment(
          commenterImg: 'assets/products/female1.jpg',
          commenterName: 'Mary Shaw',
          commentTime: '3w',
          commentContent: 'What a lovely photo we got there!',
        ),
      ],
    ),
    UserPost(
      id: 'post2', // Unique ID for each post
      userimg: 'assets/Boy2.jpg',
      username: 'John Doe',
     time: Timestamp.now(),
      postcontent: 'A coffee today keeps your worry a day.',
      postimg: 'assets/04.jpg',
      numcomments: '900 comments',
      numshare: '1k shares',
      isLiked: false,
      comments: [
        UserComment(
          commenterImg: 'assets/products/female2.jpg',
          commenterName: 'Kim Kardashian',
          commentTime: '5w',
          commentContent: 'Try the latte one!',
        ),
      ],
    ),
    UserPost(
      id: 'post3', // Unique ID for each post
      userimg: 'assets/Boy3.jpg',
      username: 'Christian Raye',
time: Timestamp.now(),
      postcontent: 'Hi there!',
      postimg: 'assets/02.jpg',
      numcomments: '32 comments',
      numshare: '11 shares',
      isLiked: false,
      comments: [
        UserComment(
          commenterImg: 'assets/products/female3.jpg',
          commenterName: 'Chris Tina',
          commentTime: '7w',
          commentContent: 'Hello There!',
        ),
      ],
    ),
  ];

  // List of Friends
  List<Friend> friendList = [
    Friend(img: 'assets/female01.jpg', name: 'Mary Shaw'),
    Friend(img: 'assets/male1.jpg', name: 'Raye D. Ban'),
    Friend(img: 'assets/male2.jpg', name: 'Eliot Anderson'),
    Friend(img: 'assets/male3.jpg', name: 'East T. Dante'),
    Friend(img: 'assets/male4.jpg', name: 'Corny Toe'),
    Friend(img: 'assets/male5.jpg', name: 'Sam Smith'),
  ];

  // Account Information
  Account myUserAccount = Account(
    name: 'Juliana Gwyneth Razonable',
    email: 'gwynraz@gmail.com',
    img: 'assets/me.jpg',
    numFollowers: '936',
    numPosts: '80',
    numFollowing: '589',
    numFriends: '4,070',
  );
}
