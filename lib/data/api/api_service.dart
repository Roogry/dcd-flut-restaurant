import 'dart:convert';

import 'package:dcd_flut_restaurant/data/model/review.dart';
import 'package:http/http.dart' as http;
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantResponse> getRestaurants() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if(!isConnected) throw Exception('No internet connection');

    final response = await http.get(Uri.parse('$_baseUrl/list'));
    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if(!isConnected) throw Exception('No internet connection');

    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<RestaurantSearchResponse> searchRestaurants(String query) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if(!isConnected) throw Exception('No internet connection');

    final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));

    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }

  Future<ReviewResponse> submitReview(Map<String, dynamic> data) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if(!isConnected) throw Exception('No internet connection');
    
    final response = await http.post(
      Uri.parse('$_baseUrl/review'),
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return ReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to submit review');
    }
  }
}
