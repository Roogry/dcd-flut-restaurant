import 'dart:convert';

import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:flutter/services.dart';

class LocalJson {
  static const String restaurantPath = 'assets/json/local_restaurant.json';

  static Future<List<Restaurant>> getData() async {
    String stringData = await rootBundle.loadString(restaurantPath);
    var jsonData = jsonDecode(stringData);

    return Restaurants.fromJson(jsonData).restaurants?? [];
  }
}