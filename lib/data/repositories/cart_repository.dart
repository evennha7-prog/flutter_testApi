import 'dart:convert';
import 'package:ecommerce_api/data/datasources/preference_provider.dart';
import 'package:ecommerce_api/data/models/cart_item_model.dart';

class CartRepository {
  static const String _cartStorageKey = 'local_cart_items_v1';
  final PreferenceProvider _prefs;

  CartRepository({PreferenceProvider? prefs})
      : _prefs = prefs ?? PreferenceProvider.instance;

  Future<List<CartItemModel>> loadCart() async {
    try {
      final jsonString = _prefs.getString(_cartStorageKey);
      if (jsonString.trim().isEmpty) {
        return [];
      }
      final decoded = jsonDecode(jsonString);
      if (decoded is List) {
        return decoded
            .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {
      // In case of parsing error, return empty list
    }
    return [];
  }

  Future<void> saveCart(List<CartItemModel> items) async {
    try {
      final jsonList = items.map((item) => item.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await _prefs.setString(_cartStorageKey, jsonString);
    } catch (_) {}
  }

  Future<void> clearCart() async {
    try {
      await _prefs.setString(_cartStorageKey, '');
    } catch (_) {}
  }
}
