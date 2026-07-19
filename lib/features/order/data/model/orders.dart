import 'package:e_commerce_nti/features/order/data/model/order_data.dart';

class Orders {
  final List<OrderData>? active;
  final List<OrderData>? completed;
  final List<OrderData>? canceled;

  Orders({this.active, this.completed, this.canceled});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      active: (json["active"] as List?)
          ?.map((e) => OrderData.fromJson(e))
          .toList(),
      completed: (json["completed"] as List?)
          ?.map((e) => OrderData.fromJson(e))
          .toList(),
      canceled: (json["canceled"] as List?)
          ?.map((e) => OrderData.fromJson(e))
          .toList(),
    );
  }
}
