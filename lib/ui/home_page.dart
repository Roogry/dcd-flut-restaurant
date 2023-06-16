import 'package:dcd_flut_restaurant/common/navigation.dart';
import 'package:dcd_flut_restaurant/ui/bookmarks_page.dart';
import 'package:dcd_flut_restaurant/ui/settings_page.dart';
import 'package:dcd_flut_restaurant/utils/notification_helper.dart';
import 'package:dcd_flut_restaurant/utils/state_enum.dart';
import 'package:dcd_flut_restaurant/common/styles.dart';
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:dcd_flut_restaurant/provider/restaurant_list_provider.dart';
import 'package:dcd_flut_restaurant/ui/restaurant_detail_page.dart';
import 'package:dcd_flut_restaurant/widgets/restaurant_card.dart';
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
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    _searchController.dispose();
    selectNotificationSubject.close();
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
                _topSection(),
                const SizedBox(height: 16),
                _searchField(),
                const SizedBox(height: 24),
                _buildList(context)
              ],
            ),
          ),
        ),
      ),
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

  Widget _topSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigation.intentWithData(BookmarksPage.routeName, null);
          },
          icon: const Icon(Icons.bookmarks_rounded),
          color: blackText,
        ),
        IconButton(
          onPressed: () {
            Navigation.intentWithData(SettingsPage.routeName, null);
          },
          icon: const Icon(Icons.settings),
          color: blackText,
        ),
      ],
    );
  }
}
