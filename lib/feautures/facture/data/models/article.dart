class Article {
  int id;
  String name;
  String description;
  double unitPrice;
  int quantity;

  double get totalHT => unitPrice * quantity;

  Article({
    required this.id,
    required this.name,
    required this.description,
    required this.unitPrice,
    required this.quantity,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }
}
