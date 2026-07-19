import 'package:e_commerce_nti/features/home/data/models/products_model.dart';

class CategoryModel {
  List<Categories2>? categories;
  bool? status;

  CategoryModel({this.categories, this.status});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories2>[];
      json['categories'].forEach((v) {
        categories!.add(Categories2.fromJson(v));
      });
    }
    status = json['status'];
  }
}

class Categories2 {
  String? description;
  int? id;
  String? imagePath;
  List<Products>? products;
  String? title;

  Categories2({
    this.description,
    this.id,
    this.imagePath,
    this.products,
    this.title,
  });

  Categories2.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    imagePath = json['image_path'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    title = json['title'];
  }
}
