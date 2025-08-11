// category_icon_mapper.dart
import 'package:flutter/material.dart';

class CategoryIconMapper {
  static final Map<String, IconData> _categoryIcons = {
    "Entertainment": Icons.movie,
    "Income": Icons.attach_money,
    "Groceries": Icons.local_grocery_store,
    "Transport": Icons.directions_bus,
    "Shopping": Icons.shopping_bag,
    "Bills": Icons.receipt_long,
    "Dining": Icons.restaurant,
    "Travel": Icons.flight_takeoff,
    "Health": Icons.favorite,
    "Education": Icons.school,
    "Rent": Icons.home,
    "Utilities": Icons.lightbulb_outline,
    "Insurance": Icons.security,
    "Gifts": Icons.card_giftcard,
    "Subscriptions": Icons.subscriptions,
    "Fuel": Icons.local_gas_station,
    "Savings": Icons.savings,
    "Taxes": Icons.account_balance,
    "Pets": Icons.pets,
    "Miscellaneous": Icons.category,
  };

  static IconData getIcon(String category) {
    return _categoryIcons[category] ?? Icons.category;
  }

  static List<String> getCategories() {
    return _categoryIcons.keys.toList();
  }
}
