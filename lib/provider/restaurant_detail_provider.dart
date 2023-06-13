import 'package:dcd_flut_restaurant/common/state_enum.dart';
import 'package:dcd_flut_restaurant/data/api/api_service.dart';
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
 
  RestaurantDetailProvider({required this.apiService});

  late RestaurantDetailResponse _result;
  RestaurantDetailResponse get result => _result;

  ResultState _state = ResultState.empty;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getRestaurantDetail(id);
      if (response.restaurant == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Detail restaurant tidak didapatkan';
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
}
