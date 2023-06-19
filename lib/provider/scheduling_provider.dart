import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dcd_flut_restaurant/utils/background_service.dart';
import 'package:dcd_flut_restaurant/utils/date_time_helper.dart';
import 'package:flutter/material.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
 
  bool get isScheduled => _isScheduled;
 
  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      // print('Scheduling Recommendation Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(days: 1),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      // print('Scheduling Recommendation Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}