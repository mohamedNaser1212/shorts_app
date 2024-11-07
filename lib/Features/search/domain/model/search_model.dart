class SearchModel {
  // final String id;
  // final String thumbnail;
  // final String videoUrl;
  // final String description;
  // final UserEntity user;
  final String name;
  final String profilePic;

  SearchModel({
    // required this.id,
    // required this.thumbnail,
    // required this.videoUrl,
    // required this.description,
    required this.name,
    required this.profilePic,
  });

  // Factory constructor to create a SearchModel from a Firestore document
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      // id: json['id'] ?? '',
      // thumbnail: json['thumbnail'] ?? '',
      // videoUrl: json['videoUrl'] ?? '',
      // description: json['description'] ?? '',
      name: json['name'] ?? '',
      profilePic: json['profilePic'] ?? '',
    );
  }
}
