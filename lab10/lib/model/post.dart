class Post {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory Post.fromJson(String id, Map<String, dynamic> json) => Post(
    id: id,
    title: json['title'],
    description: json['description'],
    imageUrl: json['imageUrl'],
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
  };
}
