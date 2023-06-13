import 'package:dcd_flut_restaurant/common/state_enum.dart';
import 'package:dcd_flut_restaurant/data/api/api_service.dart';
import 'package:dcd_flut_restaurant/data/model/review.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReviewAddProvicer extends ChangeNotifier {
  final ApiService apiService;
 
  ReviewAddProvicer({required this.apiService});

  late ReviewResponse _result;
  ReviewResponse get result => _result;

  ResultState _state = ResultState.empty;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> submitReview(Map<String, dynamic> data) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.submitReview(data);
      if (response.customerReviews == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Review gagal ditambahkan';
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
