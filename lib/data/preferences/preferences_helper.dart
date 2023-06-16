import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});
  
  static const dailyRecommendation = 'DAILY_RECOMMENDATION';

  Future<bool> get isDailyRecommendationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyRecommendation) ?? false;
  }

  void setDailyRecommendations(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyRecommendation, value);
  }
}
