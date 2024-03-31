class FoodItem {
  final String title;
  final String description;
  final String price;
  final String imageUrl;
  final String category;

  FoodItem(
      {required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.category});

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      title: json['title'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      category: json['category'],
    );
  }
}
