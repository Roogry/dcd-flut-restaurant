import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantResponse> getRestaurants() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));
    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<RestaurantSearchResponse> searchRestaurants(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));

    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }
}
