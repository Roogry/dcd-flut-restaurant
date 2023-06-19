import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dcd_flut_restaurant/common/navigation.dart';
import 'package:dcd_flut_restaurant/common/styles.dart';
import 'package:dcd_flut_restaurant/data/api/api_service.dart';
import 'package:dcd_flut_restaurant/data/db/database_helper.dart';
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:dcd_flut_restaurant/data/preferences/preferences_helper.dart';
import 'package:dcd_flut_restaurant/provider/database_provider.dart';
import 'package:dcd_flut_restaurant/provider/preferences_provider.dart';
import 'package:dcd_flut_restaurant/provider/restaurant_detail_provider.dart';
import 'package:dcd_flut_restaurant/provider/restaurant_list_provider.dart';
import 'package:dcd_flut_restaurant/provider/review_add_provider.dart';
import 'package:dcd_flut_restaurant/provider/scheduling_provider.dart';
import 'package:dcd_flut_restaurant/ui/bookmarks_page.dart';
import 'package:dcd_flut_restaurant/ui/home_page.dart';
import 'package:dcd_flut_restaurant/ui/restaurant_detail_page.dart';
import 'package:dcd_flut_restaurant/ui/settings_page.dart';
import 'package:dcd_flut_restaurant/ui/splash_screen.dart';
import 'package:dcd_flut_restaurant/ui/write_review_page.dart';
import 'package:dcd_flut_restaurant/utils/background_service.dart';
import 'package:dcd_flut_restaurant/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantDetailProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => ReviewAddProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
              ),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: myTextTheme,
        ),
        navigatorKey: navigatorKey,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomePage.routeName: (context) => const HomePage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String? ?? '',
              ),
          WriteReviewPage.routeName: (context) => WriteReviewPage(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant? ??
                        Restaurant(),
              ),
          BookmarksPage.routeName: (context) => const BookmarksPage(),
          SettingsPage.routeName: (context) => const SettingsPage(),
        },
      ),
    );
  }
}
