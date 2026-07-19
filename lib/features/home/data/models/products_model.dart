class ProductsModel {
  List<Products>? products;
  bool? status;

  ProductsModel({this.products, this.status});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    status = json['status'];
  }
}

class Products {
  int? bestSeller;
  Category? category;
  String? description;
  int? id;
  String? imagePath;
  bool? isFavorite;
  String? name;
  num? price;
  double? rating;

  Products({
    this.bestSeller,
    this.category,
    this.description,
    this.id,
    this.imagePath,
    this.isFavorite,
    this.name,
    this.price,
    this.rating,
  });

  Products.fromJson(Map<String, dynamic> json) {
    bestSeller = json['best_seller'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    description = json['description'];
    id = json['id'];
    imagePath = json['image_path'];
    isFavorite = json['is_favorite'];
    name = json['name'];
    price = json['price'];
    rating = json['rating'];
  }
}

class Category {
  String? description;
  int? id;
  String? imagePath;
  String? title;

  Category({this.description, this.id, this.imagePath, this.title});

  Category.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    imagePath = json['image_path'];
    title = json['title'];
  }
}
