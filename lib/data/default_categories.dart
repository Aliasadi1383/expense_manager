import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';

List<Category> defaultCategories = [
  Category(
    name: 'Food & Dining',
    icon: Icons.restaurant,
    backgroundColor: Color(0xFFD97706),
  ),
  Category(
    name: 'Shopping',
    icon: Icons.shopping_bag,
    backgroundColor: Color(0xFF9333EA),
  ),
  Category(
    name: 'Entertainment',
    icon: Icons.videogame_asset,
    backgroundColor: Color(0xFFDB2777),
  ),
  Category(
    name: 'Transportation',
    icon: Icons.directions_car,
    backgroundColor: Color(0xFF2563EB),
  ),
  Category(
    name: 'Home & Utilities',
    icon: Icons.home,
    backgroundColor: AppColors.success,
  ),
  Category(
    name: 'Bills & Frees',
    icon: Icons.request_quote,
    backgroundColor: Colors.red,
  ),
  Category(
    name: 'Health & Wellness',
    icon: Icons.monitor_heart,
    backgroundColor: Colors.green,
  ),
  Category(name: 'Other', icon: Icons.more_horiz, backgroundColor: Colors.grey),
];
