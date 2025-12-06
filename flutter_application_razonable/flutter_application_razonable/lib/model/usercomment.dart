class UserComment {
  String commenterImg;
  String commenterName;
  String commentTime;
  String commentContent;

  UserComment({
    required this.commenterImg,
    required this.commenterName,
    required this.commentTime,
    required this.commentContent,
  });

  // From JSON
  factory UserComment.fromJson(Map<String, dynamic> json) {
    return UserComment(
      commenterImg: json['commenterImg'] as String? ?? '', // Use `as String?` for type safety
      commenterName: json['commenterName'] as String? ?? '',
      commentTime: json['commentTime'] as String? ?? '',
      commentContent: json['commentContent'] as String? ?? '',
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'commenterImg': commenterImg,
      'commenterName': commenterName,
      'commentTime': commentTime,
      'commentContent': commentContent,
    };
  }
}
