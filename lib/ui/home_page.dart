import 'dart:convert';

import 'package:dcd_flut_restaurant/common/styles.dart';
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:dcd_flut_restaurant/ui/restaurant_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          children: [
            RichText(
              text: const TextSpan(
                text: 'Halo, ',
                style: TextStyle(
                  fontSize: 20,
                  color: blackText,
                ),
                children: [
                  TextSpan(
                    text: 'Pelanggan',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Recommendation restaurant for you',
              style: TextStyle(
                fontSize: 14,
                color: secondaryText,
              ),
            ),
            const SizedBox(height: 24),
            _buildList(context)
          ],
        ),
      )
    );
  }

  FutureBuilder<String> _buildList(BuildContext context) {
    List<Restaurant> restaurants = [];

    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var json = jsonDecode(snapshot.data.toString());
        restaurants = Restaurants.fromJson(json).restaurants?? [];

        return GridView.count(
          crossAxisCount: 2,
          childAspectRatio: .85,
          shrinkWrap: true,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          physics: const NeverScrollableScrollPhysics(),
          children: restaurants.map((Restaurant restaurant) {
            return _buildRestaurantItem(context, restaurant);
          }).toList(),
        );
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RestaurantDetailPage.routeName,
          arguments: restaurant,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 15,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: restaurant.pictureId!,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  restaurant.pictureId!,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  restaurant.name?? '-',
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/pin_fill.svg',
                    height: 10,
                    width: 10,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      restaurant.name?? '-',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: secondaryText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}