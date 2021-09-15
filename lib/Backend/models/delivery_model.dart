// To parse this JSON data, do
//
//     final deliveryModel = deliveryModelFromJson(jsonString);

import 'dart:convert';

DeliveryModel deliveryModelFromJson(String str) =>
    DeliveryModel.fromJson(json.decode(str));

String deliveryModelToJson(DeliveryModel data) => json.encode(data.toJson());

class DeliveryModel {
  DeliveryModel({
    this.orderInfo,
    this.restaurantLocation,
    this.restaurant,
    this.meals,
    this.driver,
  });

  OrderInfo orderInfo;
  List<double> restaurantLocation;
  Restaurant restaurant;
  List<DeliveryModelMeal> meals;
  bool driver;

  factory DeliveryModel.fromJson(Map<String, dynamic> json)  {
    print("whatthe${json["orderInfo"]}");
    print("whatthe${json["orderInfo"]["price"]}");
    return
  DeliveryModel(
  orderInfo: OrderInfo.fromJson(json["orderInfo"]),
  restaurantLocation: List<double>.from(
  json["restaurantLocation"].map((x) => x.toDouble())),
  restaurant: Restaurant.fromJson(json["restaurant"]),
  meals: List<DeliveryModelMeal>.from(
  json["meals"].map((x) => DeliveryModelMeal.fromJson(x))),
  driver: json["driver"],

  );
}

  Map<String, dynamic> toJson() => {
        "orderInfo": orderInfo.toJson(),
        "restaurantLocation":
            List<dynamic>.from(restaurantLocation.map((x) => x)),
        "restaurant": restaurant.toJson(),
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
        "driver": driver,
      };
}

class DeliveryModelMeal {
  DeliveryModelMeal({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory DeliveryModelMeal.fromJson(Map<String, dynamic> json)
  {
    print("thats is name${json["name"]}");
    return
      DeliveryModelMeal(
  id: json["id"],
  name: json["name"],
  );
}

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class OrderInfo {
  OrderInfo({
    this.id,
    this.rests,
    this.user,
    this.userLocation,
    this.createdAt,
    this.totalPrice,
    this.price,
  });

  int id;
  List<Rest> rests;
  User user;
  UserLocation userLocation;
  DateTime createdAt;
  num totalPrice;
  num price;

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        id: json["id"],
        rests: List<Rest>.from(json["rests"].map((x) => Rest.fromJson(x))),
        user: User.fromJson(json["user"]),
        userLocation: UserLocation.fromJson(json["userLocation"]),
        createdAt: DateTime.parse(json["createdAt"]),
        totalPrice: json["totalPrice"],
    price:json["price"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rests": List<dynamic>.from(rests.map((x) => x.toJson())),
        "user": user.toJson(),
        "userLocation": userLocation.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "totalPrice": totalPrice,
      };
}

class Rest {
  Rest({
    this.status,
    this.id,
    this.restId,
    this.meals,
  });

  String status;
  String id;
  int restId;
  List<RestMeal> meals;

  factory Rest.fromJson(Map<String, dynamic> json) {

    return
  Rest(
  status: json["status"],
  id: json["_id"],
  restId: json["id"],
  meals:
  List<RestMeal>.from(json["meals"].map((x) => RestMeal.fromJson(x))),
  );
}

  Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "id": restId,
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class RestMeal {
  RestMeal({
    this.additions,
    this.price,
    this.quantity,
    this.id,
    this.meal,
    this.size,
  });

  List<dynamic> additions;
  num price;
  num quantity;
  String id;
  num meal;
  String size;

  factory RestMeal.fromJson(Map<String, dynamic> json) => RestMeal(
        additions: List<dynamic>.from(json["additions"].map((x) => x)),
        price: json["price"],
        quantity: json["quantity"],
        id: json["_id"],
        meal: json["meal"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "additions": List<dynamic>.from(additions.map((x) => x)),
        "price": price,
        "quantity": quantity,
        "_id": id,
        "meal": meal,
        "size": size,
      };
}

class User {
  User({
    this.id,
    this.phone,
    this.role,
    this.address,
  });

  int id;
  String phone;
  String role;
  List<UserAddress> address;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        phone: json["phone"],
        role: json["role"],
        address: List<UserAddress>.from(
            json["address"].map((x) => UserAddress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "role": role,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
      };
}

class UserAddress {
  UserAddress({
    this.location,
    this.id,
    this.sub,
    this.country,
    this.city,
    this.address,
  });

  Location location;
  String id;
  String sub;
  String country;
  String city;
  String address;

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
        location: Location.fromJson(json["location"]),
        id: json["_id"],
        sub: json["sub"],
        country: json["country"],
        city: json["city"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "_id": id,
        "sub": sub,
        "country": country,
        "city": city,
        "address": address,
      };
}

class Location {
  Location({
    this.type,
    this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class UserLocation {
  UserLocation({
    this.type,
    this.coordinates,
    this.address,
  });

  String type;
  List<double> coordinates;
  String address;

  factory UserLocation.fromJson(Map<String, dynamic> json) => UserLocation(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "address": address,
      };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.about,
    this.photo,
    this.restaurantWallet,
    this.email,
    this.phone,
    this.enabled,
    this.pushTokens,
    this.address,
    this.minDeliveryTime,
    this.minOrderValue,
    this.deliveryCharge,
    this.paymentMethod,
    this.rating,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String about;
  String photo;
  num restaurantWallet;
  String email;
  List<String> phone;
  bool enabled;
  List<dynamic> pushTokens;
  List<RestaurantAddress> address;
  String minDeliveryTime;
  num minOrderValue;
  num deliveryCharge;
  String paymentMethod;
  int rating;
  DateTime createdAt;
  DateTime updatedAt;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        about: json["about"],
        photo: json["photo"],
        restaurantWallet: json["restaurantWallet"],
        email: json["email"],
        phone: List<String>.from(json["phone"].map((x) => x)),
        enabled: json["enabled"],
        pushTokens: List<dynamic>.from(json["pushTokens"].map((x) => x)),
        address: List<RestaurantAddress>.from(
            json["address"].map((x) => RestaurantAddress.fromJson(x))),
        minDeliveryTime: json["minDeliveryTime"],
        minOrderValue: json["minOrderValue"],
        deliveryCharge: json["deliveryCharge"],
        paymentMethod: json["paymentMethod"],
        rating: json["rating"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "about": about,
        "photo": photo,
        "restaurantWallet": restaurantWallet,
        "email": email,
        "phone": List<dynamic>.from(phone.map((x) => x)),
        "enabled": enabled,
        "pushTokens": List<dynamic>.from(pushTokens.map((x) => x)),
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "minDeliveryTime": minDeliveryTime,
        "minOrderValue": minOrderValue,
        "deliveryCharge": deliveryCharge,
        "paymentMethod": paymentMethod,
        "rating": rating,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class RestaurantAddress {
  RestaurantAddress({
    this.location,
    this.id,
    this.sub,
  });

  Location location;
  String id;
  String sub;

  factory RestaurantAddress.fromJson(Map<String, dynamic> json) =>
      RestaurantAddress(
        location: Location.fromJson(json["location"]),
        id: json["_id"],
        sub: json["sub"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "_id": id,
        "sub": sub,
      };
}
