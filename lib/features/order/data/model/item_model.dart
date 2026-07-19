class ItemModel {
  final int? id;
  final String? name;
  final String? description;
  final String? imagePath;
  final double? price;
  final int? quantity;
  final double? rating;
  final double? totalPrice;

  ItemModel({
    this.id,
    this.name,
    this.description,
    this.imagePath,
    this.price,
    this.quantity,
    this.rating,
    this.totalPrice,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      imagePath: json["image_path"],
      price: (json["price"] as num?)?.toDouble(),
      quantity: json["quantity"],
      rating: (json["rating"] as num?)?.toDouble(),
      totalPrice: (json["total_price"] as num?)?.toDouble(),
    );
  }
}
