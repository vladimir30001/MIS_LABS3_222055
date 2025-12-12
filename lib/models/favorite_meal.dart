class FavoriteMeal {
  final String id;
  final String name;
  final String thumbnail;

  FavoriteMeal({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory FavoriteMeal.fromJson(Map<String, dynamic> json) {
    return FavoriteMeal(
      id: json['id'],
      name: json['name'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
    };
  }
}
