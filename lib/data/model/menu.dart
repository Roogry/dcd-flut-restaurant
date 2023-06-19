import 'dart:convert';

import 'package:dcd_flut_restaurant/data/model/drink.dart';
import 'package:dcd_flut_restaurant/data/model/food.dart';

class Menu {
  List<Food>? foods;
  List<Drink>? drinks;

  Menu({
    this.foods,
    this.drinks,
  });

  factory Menu.fromRawJson(String str) => Menu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      foods: json["foods"] == null
          ? []
          : List<Food>.from(json["foods"]!.map((x) => Food.fromJson(x))),
      drinks: json["drinks"] == null
          ? []
          : List<Drink>.from(json["drinks"]!.map((x) => Drink.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "foods": foods == null
          ? []
          : List<dynamic>.from(foods!.map((x) => x.toJson())),
      "drinks": drinks == null
          ? []
          : List<dynamic>.from(drinks!.map((x) => x.toJson())),
    };
  }
}
