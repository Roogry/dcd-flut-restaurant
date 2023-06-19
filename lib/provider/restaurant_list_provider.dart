import 'package:dcd_flut_restaurant/utils/state_enum.dart';
import 'package:dcd_flut_restaurant/data/api/api_service.dart';
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:flutter/material.dart';
 
class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;
 
  RestaurantListProvider({required this.apiService}) {
    fetchAllRestaurant();
  }
 
  late RestaurantResponse _result;
  RestaurantResponse get result => _result;

  late RestaurantSearchResponse _searchResult;
  RestaurantSearchResponse get searchResult => _searchResult;
 
  ResultState _state = ResultState.empty;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
 
  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getRestaurants();
      if (response.restaurants == null || response.restaurants!.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Belum ada restaurant';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _result = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> fetchRestaurantSearch(String query) async {
    _searchQuery = query;
    
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.searchRestaurants(query);
      if (response.restaurants == null || (response.restaurants?.length?? 0) < 1) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Restaurant tidak ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}