class UserData {
  final bool? status;
  final UserModel? user;

  UserData({this.status, this.user});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      status: json["status"],
      user: json["user"] != null ? UserModel.fromJson(json["user"]) : null,
    );
  }
}

class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? imagePath;
  final List<FavoriteProduct>? favoriteProducts;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.imagePath,
    this.favoriteProducts,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      imagePath: json["image_path"],
      favoriteProducts: json["favorite_products"] == null
          ? []
          : List<FavoriteProduct>.from(
              json["favorite_products"].map((x) => FavoriteProduct.fromJson(x)),
            ),
    );
  }
}

class FavoriteProduct {
  final int? id;
  final String? name;
  final String? description;
  final String? imagePath;
  final double? price;
  final double? rating;
  final int? bestSeller;

  FavoriteProduct({
    this.id,
    this.name,
    this.description,
    this.imagePath,
    this.price,
    this.rating,
    this.bestSeller,
  });

  factory FavoriteProduct.fromJson(Map<String, dynamic> json) {
    return FavoriteProduct(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      imagePath: json["image_path"],
      price: (json["price"] as num?)?.toDouble(),
      rating: (json["rating"] as num?)?.toDouble(),
      bestSeller: json["best_seller"],
    );
  }
}
