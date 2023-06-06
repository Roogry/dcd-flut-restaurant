// To parse this JSON data, do
//
//     final restaurants = restaurantsFromJson(jsonString);

import 'dart:convert';

class Restaurants {
    List<Restaurant>? restaurants;

    Restaurants({
        this.restaurants,
    });

    factory Restaurants.fromRawJson(String str) => Restaurants.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        restaurants: json["restaurants"] == null ? [] : List<Restaurant>.from(json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "restaurants": restaurants == null ? [] : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
    };
}

class Restaurant {
    String? id;
    String? name;
    String? description;
    String? pictureId;
    String? city;
    double? rating;
    Menus? menus;

    Restaurant({
        this.id,
        this.name,
        this.description,
        this.pictureId,
        this.city,
        this.rating,
        this.menus,
    });

    factory Restaurant.fromRawJson(String str) => Restaurant.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
        menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus?.toJson(),
    };
}

class Menus {
    List<Drink>? foods;
    List<Drink>? drinks;

    Menus({
        this.foods,
        this.drinks,
    });

    factory Menus.fromRawJson(String str) => Menus.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: json["foods"] == null ? [] : List<Drink>.from(json["foods"]!.map((x) => Drink.fromJson(x))),
        drinks: json["drinks"] == null ? [] : List<Drink>.from(json["drinks"]!.map((x) => Drink.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "foods": foods == null ? [] : List<dynamic>.from(foods!.map((x) => x.toJson())),
        "drinks": drinks == null ? [] : List<dynamic>.from(drinks!.map((x) => x.toJson())),
    };
}

class Drink {
    String? name;

    Drink({
        this.name,
    });

    factory Drink.fromRawJson(String str) => Drink.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
