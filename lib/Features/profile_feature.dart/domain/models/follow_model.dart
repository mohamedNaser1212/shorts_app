class FollowModel {
  final String targetUserId;
  final String targetUserName;
  bool isFollowing;

  FollowModel({
    required this.targetUserId,
    required this.targetUserName,
    this.isFollowing =
        false, // Default to false when no follow status is provided
  });

  // Convert to/from a Map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'targetUserId': targetUserId,
      'targetUserName': targetUserName,
      'isFollowing': isFollowing,
    };
  }

  // Convert Firestore document to FollowModel
  factory FollowModel.fromMap(Map<String, dynamic> map) {
    return FollowModel(
      targetUserId: map['targetUserId'],
      targetUserName: map['targetUserName'],
      isFollowing:
          map['isFollowing'] ?? false, // Default to false if not present
    );
  }
}
