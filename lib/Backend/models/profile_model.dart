// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.id,
    this.username,
    this.userWallet,
    this.email,
    this.phone,
    this.enabled,
    this.pushTokens,
    this.role,
    this.address,
    this.currentLocation,
    this.driverWallet,
    this.onlineStatus,
    this.orders,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String username;
  int userWallet;
  String email;
  String phone;
  bool enabled;
  List<dynamic> pushTokens;
  String role;
  List<dynamic> address;
  CurrentLocation currentLocation;
  int driverWallet;
  String onlineStatus;
  List<Order> orders;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        username: json["username"],
        userWallet: json["userWallet"],
        email: json["email"],
        phone: json["phone"],
        enabled: json["enabled"],
        pushTokens: List<dynamic>.from(json["pushTokens"].map((x) => x)),
        role: json["role"],
        address: List<dynamic>.from(json["address"].map((x) => x)),
        currentLocation: CurrentLocation.fromJson(json["currentLocation"]),
        driverWallet: json["driverWallet"],
        onlineStatus: json["onlineStatus"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "userWallet": userWallet,
        "email": email,
        "phone": phone,
        "enabled": enabled,
        "pushTokens": List<dynamic>.from(pushTokens.map((x) => x)),
        "role": role,
        "address": List<dynamic>.from(address.map((x) => x)),
        "currentLocation": currentLocation.toJson(),
        "driverWallet": driverWallet,
        "onlineStatus": onlineStatus,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class CurrentLocation {
  CurrentLocation({
    this.type,
    this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory CurrentLocation.fromJson(Map<String, dynamic> json) =>
      CurrentLocation(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Order {
  Order({
    this.id,
    this.order,
    this.restaurant,
  });

  String id;
  int order;
  int restaurant;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        order: json["order"],
        restaurant: json["restaurant"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "order": order,
        "restaurant": restaurant,
      };
}
