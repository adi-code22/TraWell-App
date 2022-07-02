// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    required this.id,
    required this.itemId,
    required this.itemName,
    required this.img,
    required this.description,
    required this.location,
    required this.price,
  });

  String id;
  String itemId;
  String itemName;
  String img;
  String description;
  String location;
  int price;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        itemId: json["itemID"],
        itemName: json["itemName"],
        img: json["img"],
        description: json["description"],
        location: json["location"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "itemID": itemId,
        "itemName": itemName,
        "img": img,
        "description": description,
        "location": location,
        "price": price,
      };
}
