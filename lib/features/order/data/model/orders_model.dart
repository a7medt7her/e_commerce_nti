import 'package:e_commerce_nti/features/order/data/model/orders.dart';

class OrdersModel {
  final Orders? orders;
  final bool? status;

  OrdersModel({this.orders, this.status});

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      orders: json["orders"] == null ? null : Orders.fromJson(json["orders"]),
      status: json["status"],
    );
  }
}
