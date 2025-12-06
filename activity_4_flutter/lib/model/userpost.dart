class Userpost {
  String userimg;
  String username;
  String time;
  String postcontent;
  String postimg;
  int numcomments;
  int numshare;
  int numlikes;
  bool isLiked;
  List<String> comments; 

  Userpost({
    required this.userimg,
    required this.username,
    required this.time,
    required this.postcontent,
    required this.postimg,
    this.numcomments = 0,
    this.numshare = 0,
    this.numlikes = 0,
    this.isLiked = false,
    List<String>? comments,
  }) : comments = comments ?? [];
}
