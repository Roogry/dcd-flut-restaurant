import 'package:dcd_flut_restaurant/data/preferences/preferences_helper.dart';
import 'package:dcd_flut_restaurant/provider/preferences_provider.dart';
import 'package:dcd_flut_restaurant/provider/scheduling_provider.dart';
import 'package:dcd_flut_restaurant/ui/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget createSettingPage() => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: const MaterialApp(
        home: SettingsPage(),
      ),
    );

void main() {
  group('Settings Page Widget Test', () {

    testWidgets('Test if switch shows up',
        (WidgetTester tester) async {
      await tester.pumpWidget(createSettingPage());
      expect(find.byType(Switch), findsOneWidget);
    });
  });
}
