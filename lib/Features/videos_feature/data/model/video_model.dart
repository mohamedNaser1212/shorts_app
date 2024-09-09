class VideoModel {
  final String id;
  final String title;
  final String thumbnail;
  final String videoUrl;
  final String? description;

  VideoModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.videoUrl,
    this.description,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      videoUrl: json['videoUrl'],
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'videoUrl': videoUrl,
      'description': description,
    };
  }
}
