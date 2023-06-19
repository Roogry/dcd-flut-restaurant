import 'dart:ui';

import 'package:dcd_flut_restaurant/common/navigation.dart';
import 'package:dcd_flut_restaurant/provider/database_provider.dart';
import 'package:dcd_flut_restaurant/utils/state_enum.dart';
import 'package:dcd_flut_restaurant/common/styles.dart';
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:dcd_flut_restaurant/data/model/review.dart';
import 'package:dcd_flut_restaurant/provider/restaurant_detail_provider.dart';
import 'package:dcd_flut_restaurant/ui/write_review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/detail';
  final String id;

  RestaurantDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        Provider.of<RestaurantDetailProvider>(context, listen: false)
            .fetchRestaurantDetail(widget.id);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, provider, _) {
          if (provider.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.hasData) {
            return DetailContent(
              restaurant: provider.result.restaurant!,
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  Restaurant restaurant;

  DetailContent({super.key, required this.restaurant});

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  bool isExpandedDesc = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          Provider.of<RestaurantDetailProvider>(context, listen: false)
              .fetchRestaurantDetail(widget.restaurant.id!),
      child: CustomScrollView(
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
                    onTap: () =>
                        setState(() => isExpandedDesc = !isExpandedDesc),
                    child: Text(
                      widget.restaurant.description ?? '-',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: isExpandedDesc ? null : 3,
                      overflow: isExpandedDesc
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
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
                const SizedBox(height: 24),
                const Divider(
                  color: primaryBackground,
                  thickness: 16,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Review',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigation.intentWithData(
                        WriteReviewPage.routeName,
                        widget.restaurant,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Tulis Review',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: widget.restaurant.customerReviews!.length,
                  itemBuilder: (context, index) {
                    return _reviewCard(
                      review: widget.restaurant.customerReviews![index],
                      isFirst: index == 0,
                    );
                  },
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewCard({required CustomerReview review, bool isFirst = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Visibility(
          visible: !isFirst,
          child: Divider(
            color: secondaryText.withOpacity(.3),
            thickness: .5,
          ),
        ),
        Visibility(
          visible: !isFirst,
          child: const SizedBox(height: 16),
        ),
        Text(
          review.name ?? '-',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 2),
        Text(
          review.date ?? '-',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: secondaryText,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          review.review ?? '-',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      toolbarHeight: 70,
      expandedHeight: 300,
      elevation: 0,
      title: Text(
        widget.restaurant.name ?? '-',
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
            onTap: () => Navigation.back(),
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 32),
          child: _bookmarkIcon(context),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.restaurant.pictureId!,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: Image.network(
              'https://restaurant-api.dicoding.dev/images/medium/${widget.restaurant.pictureId}',
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bookmarkIcon(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, _) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(widget.restaurant.id!),
          builder: (_, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return GestureDetector(
              onTap: () {
                if (isBookmarked) {
                  provider.removeBookmark(widget.restaurant.id!);
                } else {
                  provider.addBookmark(widget.restaurant);
                }
              },
              child: Center(
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
                      child: isBookmarked
                          ? const Icon(
                              Icons.bookmark_rounded,
                              color: blackText,
                              size: 24,
                            )
                          : const Icon(
                              Icons.bookmark_border_rounded,
                              color: blackText,
                              size: 24,
                            ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _ratingContainer(BuildContext context) {
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
