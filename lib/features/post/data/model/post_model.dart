class PostModel {
  final int id;
  final int userId;
  final String title;
  final String body;
  PostModel(
      {required this.body,
      required this.id,
      required this.title,
      required this.userId});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      body: json['body'],
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
    );
  }
}
