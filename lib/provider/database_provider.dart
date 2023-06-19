
import 'package:dcd_flut_restaurant/data/db/database_helper.dart';
import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:dcd_flut_restaurant/utils/state_enum.dart';
import 'package:flutter/material.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
 
  DatabaseProvider({required this.databaseHelper}) {
    fetchBookmarks();
  }
 
  late ResultState _state;
  ResultState get state => _state;
 
  String _message = '';
  String get message => _message;
 
  List<Restaurant> _bookmarks = [];
  List<Restaurant> get bookmarks => _bookmarks;

  Future<void> fetchBookmarks() async {
    _bookmarks = await databaseHelper.getRestaurants();
    if (_bookmarks.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Belum ada restoran tersimpan';
    }
    notifyListeners();
  }

  void addBookmark(Restaurant restaurant) async {
    try {
      await databaseHelper.insertBookmark(restaurant);
      fetchBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String id) async {
    final bookmarkedRestaurant = await databaseHelper.getBookmarkById(id);
    return bookmarkedRestaurant.isNotEmpty;
  }

  void removeBookmark(String id) async {
    try {
      await databaseHelper.removeBookmark(id);
      fetchBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}