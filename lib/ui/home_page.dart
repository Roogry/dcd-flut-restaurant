import 'package:dcd_flut_restaurant/common/state_enum.dart';
import 'package:dcd_flut_restaurant/common/styles.dart';
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:dcd_flut_restaurant/provider/restaurant_list_provider.dart';
import 'package:dcd_flut_restaurant/ui/restaurant_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return Provider.of<RestaurantListProvider>(context, listen: false)
                .fetchAllRestaurant();
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            children: [
              RichText(
                text: TextSpan(
                  text: 'Halo, ',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    color: blackText,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sobatku',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Rekomendasi restoran untuk kamu',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: secondaryText,
                ),
              ),
              const SizedBox(height: 16),
              _searchField(),
              const SizedBox(height: 24),
              _buildList(context)
            ],
          ),
        ),
      )),
    );
  }

  TextField _searchField() {
    return TextField(
      controller: _searchController,
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: blackText,
      ),
      decoration: InputDecoration(
        hintText: 'Cari restoran...',
        hintStyle: const TextStyle(color: placeholderText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: primaryBackground,
        prefixIcon: SvgPicture.asset('assets/icons/search.svg'),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 46,
          minHeight: 24,
        ),
      ),
      onChanged: (query) {
        Provider.of<RestaurantListProvider>(context, listen: false)
            .fetchRestaurantSearch(query);
      },
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantListProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          List<Restaurant> restaurants;
          if (state.searchQuery == '') {
            restaurants = state.result.restaurants!;
          } else {
            restaurants = state.searchResult.restaurants!;
          }

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
        } else if (state.state == ResultState.noData) {
          return _buildMessage(state.message);
        } else if (state.state == ResultState.error) {
          return _buildMessage(state.message);
        } else {
          return _buildMessage('Terjadi Kesalahan');
        }
      },
    );
  }

  Widget _buildMessage(String message) {
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

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RestaurantDetailPage.routeName,
          arguments: restaurant.id,
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
                  'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
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
                  restaurant.name ?? '-',
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
                      restaurant.name ?? '-',
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
