import 'package:dcd_flut_restaurant/data/preferences/preferences_helper.dart';
import 'package:flutter/material.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRecommendationsPreferences();
  }

  bool _isDailyRecommendationsActive = false;
  bool get isDailyRecommendationsActive => _isDailyRecommendationsActive;

  void _getDailyRecommendationsPreferences() async {
    _isDailyRecommendationsActive = await preferencesHelper.isDailyRecommendationActive;
    notifyListeners();
  }

  void enableDailyRecommendations(bool value) {
    preferencesHelper.setDailyRecommendations(value);
    _getDailyRecommendationsPreferences();
  }
}
