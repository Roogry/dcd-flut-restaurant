import 'package:dcd_flut_restaurant/common/styles.dart';
import 'package:dcd_flut_restaurant/data/api/api_service.dart';
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:dcd_flut_restaurant/provider/restaurant_detail_provider.dart';
import 'package:dcd_flut_restaurant/provider/restaurant_list_provider.dart';
import 'package:dcd_flut_restaurant/provider/review_add_provider.dart';
import 'package:dcd_flut_restaurant/ui/home_page.dart';
import 'package:dcd_flut_restaurant/ui/restaurant_detail_page.dart';
import 'package:dcd_flut_restaurant/ui/splash_screen.dart';
import 'package:dcd_flut_restaurant/ui/write_review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
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
          create: (_) => ReviewAddProvicer(apiService: ApiService()),
        ),
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
        },
      ),
    );
  }
}
