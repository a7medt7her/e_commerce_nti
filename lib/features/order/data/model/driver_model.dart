class DriverModel {
  final double? latitude;
  final double? longitude;
  final String? name;
  final String? phone;

  DriverModel({this.latitude, this.longitude, this.name, this.phone});

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      latitude: (json["latitude"] as num?)?.toDouble(),
      longitude: (json["longitude"] as num?)?.toDouble(),
      name: json["name"],
      phone: json["phone"],
    );
  }
}
