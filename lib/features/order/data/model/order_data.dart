import 'driver_model.dart';
import 'item_model.dart';

class OrderData {
  final int? id;
  final DriverModel? driver;
  final List<ItemModel>? items;
  final String? orderDate;
  final String? orderChangeDate;
  final double? shipping;
  final int? status;
  final double? subtotal;
  final double? tax;
  final double? total;

  OrderData({
    this.id,
    this.driver,
    this.items,
    this.orderDate,
    this.orderChangeDate,
    this.shipping,
    this.status,
    this.subtotal,
    this.tax,
    this.total,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json["id"],
      driver: json["driver"] == null
          ? null
          : DriverModel.fromJson(json["driver"]),
      items: (json["items"] as List?)
          ?.map((e) => ItemModel.fromJson(e))
          .toList(),
      orderDate: json["order_date"],
      orderChangeDate: json["order_change_date"],
      shipping: (json["shipping"] as num?)?.toDouble(),
      status: json["status"],
      subtotal: (json["subtotal"] as num?)?.toDouble(),
      tax: (json["tax"] as num?)?.toDouble(),
      total: (json["total"] as num?)?.toDouble(),
    );
  }
}
