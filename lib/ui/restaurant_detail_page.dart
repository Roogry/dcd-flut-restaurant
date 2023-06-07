import 'dart:ui';

import 'package:dcd_flut_restaurant/common/styles.dart';
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;

  RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool isExpandedDesc = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.restaurant.name!,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _ratingContainer(context),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          widget.restaurant.name ?? '-',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: secondaryText,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () => setState(() => isExpandedDesc = !isExpandedDesc),
                    child: Text(
                      widget.restaurant.description ?? '-',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: isExpandedDesc? 3 : null,
                      overflow: isExpandedDesc? TextOverflow.ellipsis : TextOverflow.visible,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(
                  color: primaryBackground,
                  thickness: 16,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Makanan',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    children: widget.restaurant.menus!.foods!
                        .map(
                          (food) => Chip(
                            label: Text(food.name ?? '-'),
                            backgroundColor: primaryBackground,
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(
                  color: primaryBackground,
                  thickness: 16,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Minuman',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    children: widget.restaurant.menus!.drinks!
                        .map(
                          (drink) => Chip(
                            label: Text(drink.name ?? '-'),
                            backgroundColor: primaryBackground,
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      toolbarHeight: 70,
      expandedHeight: 300,
      elevation: 0,
      title: Text(
        widget.restaurant.name?? '-',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      leadingWidth: 80,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.adaptive.arrow_back_rounded,
                    color: blackText,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.restaurant.pictureId!,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: Image.network(
              widget.restaurant.pictureId!,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Container _ratingContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: primaryBackground,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/star_fill.svg',
            height: 14,
            width: 14,
          ),
          const SizedBox(width: 4),
          Text(
            widget.restaurant.rating.toString(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: primaryColor,
                ),
          ),
        ],
      ),
    );
  }
}
