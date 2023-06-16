import 'package:dcd_flut_restaurant/common/styles.dart';
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:dcd_flut_restaurant/provider/database_provider.dart';
import 'package:dcd_flut_restaurant/utils/state_enum.dart';
import 'package:dcd_flut_restaurant/widgets/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarksPage extends StatelessWidget {
  static const routeName = '/bookmarks_page';

  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tersimpan'),
          backgroundColor: Colors.white,
          foregroundColor: blackText,
          toolbarHeight: 70,
          elevation: 0,
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return Provider.of<DatabaseProvider>(context, listen: false)
                  .fetchBookmarks();
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
              children: [
                _buildList(),
              ],
            ),
          ),
        ),
      );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, state, child) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          List<Restaurant> restaurants = state.bookmarks;

          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: .75,
            shrinkWrap: true,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            physics: const NeverScrollableScrollPhysics(),
            children: restaurants.map((Restaurant restaurant) {
              return RestaurantCard(
                context: context,
                restaurant: restaurant,
              );
            }).toList(),
          );
        } else if (state.state == ResultState.noData) {
          return _buildMessage(context, state.message);
        } else if (state.state == ResultState.error) {
          return _buildMessage(context, state.message);
        } else {
          return _buildMessage(context, 'Terjadi Kesalahan');
        }
      },
    );
  }

  Widget _buildMessage(BuildContext context, String message) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Icon(
            Icons.restaurant_menu_rounded,
            size: 40,
            color: primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: secondaryText,
                ),
          ),
        ],
      ),
    );
  }
}