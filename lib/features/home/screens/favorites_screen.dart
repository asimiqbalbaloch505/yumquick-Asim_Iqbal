import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Sample Data matching the Favorites design layout
  final List<Map<String, dynamic>> _favoriteItems = [
    {
      'id': '1',
      'title': 'Chicken Curry',
      'description': 'Lorem ipsum dolor sit amet, consectetur.',
      'image': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500&q=80',
      'categoryIcon': Icons.restaurant_outlined,
      'isFavorite': true,
    },
    {
      'id': '2',
      'title': 'Chicken Burger',
      'description': 'Lorem ipsum dolor sit amet, consectetur.',
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&q=80',
      'categoryIcon': Icons.lunch_dining_outlined,
      'isFavorite': true,
    },
    {
      'id': '3',
      'title': 'Broccoli Lasagna',
      'description': 'Lorem ipsum dolor sit amet, consectetur.',
      'image': 'https://images.unsplash.com/photo-1619895092538-128341789043?w=500&q=80',
      'categoryIcon': Icons.soup_kitchen_outlined,
      'isFavorite': true,
    },
    {
      'id': '4',
      'title': 'Mexican Appetizer',
      'description': 'Lorem ipsum dolor sit amet, consectetur.',
      'image': 'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?w=500&q=80',
      'categoryIcon': Icons.local_fire_department_outlined,
      'isFavorite': true,
    },
    {
      'id': '5',
      'title': 'BBQ Chicken Wings',
      'description': 'Lorem ipsum dolor sit amet, consectetur.',
      'image': 'https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=500&q=80',
      'categoryIcon': Icons.local_dining_outlined,
      'isFavorite': true,
    },
    {
      'id': '6',
      'title': 'Creamy Milkshakes',
      'description': 'Lorem ipsum dolor sit amet, consectetur.',
      'image': 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500&q=80',
      'categoryIcon': Icons.cake_outlined,
      'isFavorite': true,
    },
  ];

  void _toggleFavorite(int index) {
    setState(() {
      _favoriteItems[index]['isFavorite'] = !_favoriteItems[index]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const Text(
                    'Favorites',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Content Area Container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Subtitle Header
                    const Text(
                      "It's time to buy your favorite dish.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Grid of Favorite Items
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: _favoriteItems.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          return _buildFavoriteGridCard(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteGridCard(int index) {
    final item = _favoriteItems[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image Container with Icon Badges
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  item['image'],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.secondary,
                    child: const Icon(Icons.fastfood, color: AppColors.primary, size: 36),
                  ),
                ),
              ),

              // Category Icon Badge (Top Left)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item['categoryIcon'],
                    size: 14,
                    color: AppColors.primary,
                  ),
                ),
              ),

              // Favorite Heart Button (Top Right)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => _toggleFavorite(index),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                      size: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 6),

        // Dish Title
        Text(
          item['title'],
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),

        // Subtitle / Description
        Text(
          item['description'],
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 9,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}