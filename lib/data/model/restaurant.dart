// To parse this JSON data, do
//
//     final restaurantResponse = restaurantResponseFromJson(jsonString);

import 'dart:convert';

import 'package:dcd_flut_restaurant/data/model/category.dart';
import 'package:dcd_flut_restaurant/data/model/menu.dart';
import 'package:dcd_flut_restaurant/data/model/review.dart';

class RestaurantResponse {
  bool? error;
  String? message;
  int? count;
  List<Restaurant>? restaurants;

  RestaurantResponse({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  factory RestaurantResponse.fromRawJson(String str) =>
      RestaurantResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}

class RestaurantSearchResponse {
  bool? error;
  int? founded;
  List<Restaurant>? restaurants;

  RestaurantSearchResponse({
    this.error,
    this.founded,
    this.restaurants,
  });

  factory RestaurantSearchResponse.fromRawJson(String str) =>
      RestaurantSearchResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}

class RestaurantDetailResponse {
  bool? error;
  String? message;
  Restaurant? restaurant;

  RestaurantDetailResponse({
    this.error,
    this.message,
    this.restaurant,
  });

  factory RestaurantDetailResponse.fromRawJson(String str) =>
      RestaurantDetailResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: json["restaurant"] == null
            ? null
            : Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant?.toJson(),
      };
}

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  List<Category>? categories;
  Menus? menus;
  double? rating;
  List<CustomerReview>? customerReviews;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  factory Restaurant.fromRawJson(String str) =>
      Restaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: json["customerReviews"] == null
            ? []
            : List<CustomerReview>.from(json["customerReviews"]!
                .map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "menus": menus?.toJson(),
        "rating": rating,
        "customerReviews": customerReviews == null
            ? []
            : List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
      };
}
