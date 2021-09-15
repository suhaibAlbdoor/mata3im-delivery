// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  AuthModel({
    this.token,
    this.driver,
  });

  String token;
  Driver driver;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json["token"],
        driver: Driver.fromJson(json["driver"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "driver": driver.toJson(),
      };
}

class Driver {
  Driver({
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
  num userWallet;
  String email;
  String phone;
  bool enabled;
  List<dynamic> pushTokens;
  String role;
  List<dynamic> address;
  CurrentLocation currentLocation;
  num driverWallet;
  String onlineStatus;
  List<dynamic> orders;
  DateTime createdAt;
  DateTime updatedAt;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
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
        orders: List<dynamic>.from(json["orders"].map((x) => x)),
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
        "orders": List<dynamic>.from(orders.map((x) => x)),
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
