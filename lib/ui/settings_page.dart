import 'dart:io';

import 'package:dcd_flut_restaurant/common/styles.dart';
import 'package:dcd_flut_restaurant/provider/preferences_provider.dart';
import 'package:dcd_flut_restaurant/provider/scheduling_provider.dart';
import 'package:dcd_flut_restaurant/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.white,
        foregroundColor: blackText,
        toolbarHeight: 70,
        elevation: 0,
      ),
      body: SafeArea(
        child: _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 32,
          ),
          children: [
            Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  title: const Text('Notifikasi Restaurant'),
                  subtitle: const Text('Aktifkan notifikasi tiap jam 11 siang'),
                  value: provider.isDailyRecommendationsActive,
                  onChanged: (value) {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      scheduled.scheduledNews(value);
                      provider.enableDailyRecommendations(value);
                    }
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
