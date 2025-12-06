import 'package:activity_4_flutter/model/account.dart';
import 'package:activity_4_flutter/model/friend.dart';
import 'package:activity_4_flutter/model/usercomment.dart';
import 'package:activity_4_flutter/model/userpost.dart';

class Userdata {
  List<Userpost> userList = [

    Userpost(
      userimg: 'assets/person1.jpg',
      username: 'John Doe',
      time: '2 hrs ago',
      postcontent: 'Had a great day at the beach!',
      postimg: 'assets/beach.jpg',
      numlikes: 15,
      numcomments: 2,
      numshare: 4,
      isLiked: false,
    ),

    Userpost(
      userimg: 'assets/person2.jpg',
      username: 'Jame Smith',
      time: '3 hrs ago',
      postcontent: 'Lovin the new cafe in town',
      postimg: 'assets/cafeintown.jpg',
      numlikes: 8, 
      numcomments: 46,
      numshare: 3,
      isLiked: false,
    ),

    Userpost(
      userimg: 'assets/person3.jpg',
      username: 'Mike Johnson',
      time: '5 hrs ago',
      postcontent: 'just finish 10km in 5 mins',
      postimg: 'assets/running.jpg',
      numlikes: 21, 
      numcomments: 30,
      numshare: 20,
      isLiked: false,
    ),

    Userpost(
      userimg: 'assets/person4.jpg',
      username: 'Midget Ski',
      time: '10 hrs ago',
      postcontent: 'Fun Morning Hike!',
      postimg: 'assets/hike.jpg',
      numlikes: 5,  
      numcomments: 24,
      numshare: 5,
      isLiked: false,
    ),
  ];

  List<Friend> friendList = [
    Friend(img: 'assets/person1.jpg', name: 'Alice'),
    Friend(img: 'assets/person2.jpg', name: 'Bob'),
    Friend(img: 'assets/person3.jpg', name: 'Charlie'),
    Friend(img: 'assets/person4.jpg', name: 'Diana'),
    Friend(img: 'assets/person7.jpg', name: 'Ethan'),
    Friend(img: 'assets/person6.jpg', name: 'Michael'),
  ];

  List<Usercomment> commentList = [
    Usercomment(
        commentImg: 'assets/person2.jpg',
        commentName: 'Jane Smith',
        commenterTime: '6 hrs',
        commentContent: 'Wow Beautiful!'),
    Usercomment(
        commentImg: 'assets/person3.jpg',
        commentName: 'Yokai Ems',
        commenterTime: '3 hrs',
        commentContent: 'Cool!'),
    Usercomment(
        commentImg: 'assets/person4.jpg',
        commentName: 'Midget Ski',
        commenterTime: '8 hrs',
        commentContent: 'Wow Nice!'),
  ];

  Account myUserAccount = Account(
    name: 'Juliana Gwyneth Razonable',
    email: 'julianachuchu@gmail.com',
    img: 'assets/datdat.jpg',
    numFollowers: '240',
    numPosts: '35',
    numFollowing: '103',
    numFriends: '89',
  );
}
