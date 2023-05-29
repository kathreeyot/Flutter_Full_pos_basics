import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../required data/menu_item.dart';

class Database {
  SharedPreferences? _preferences;

  Future<List<MenuItem>> loadMenuItems() async {
    _preferences = await SharedPreferences.getInstance();
    final List<String>? savedItems = _preferences!.getStringList('menuItems');
    if (savedItems != null) {
      return savedItems
          .map((item) => MenuItem.fromMap(jsonDecode(item)))
          .toList();
    }
    return [];
  }

  Future<void> saveMenuItems(List<MenuItem> menuItems) async {
    final List<String> items =
        menuItems.map((item) => jsonEncode(item.toMap())).toList();
    await _preferences!.setStringList('menuItems', items);
  }
}
