import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import 'meal_details_screen.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  // Sample Data for Recommended Dishes
  final List<Map<String, dynamic>> _recommendations = [
    {
      'title': 'Chocolate and Fresh Fruit Crepes',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'price': 15.00,
      'rating': '5.0',
      'isNew': true,
      'image': 'https://images.unsplash.com/photo-1519676867240-f03562e64548?w=500&q=80',
      'categoryIcon': Icons.cake_outlined,
      'quantity': 1,
    },
    {
      'title': 'Bean and vegetable burger',
      'description': 'Lorem ipsum dolor sit amet, consectetur...',
      'price': 15.00,
      'rating': '4.0',
      'isNew': false,
      'image': 'https://images.unsplash.com/photo-1520072959219-c595dc870360?w=500&q=80',
      'categoryIcon': Icons.lunch_dining_outlined,
      'quantity': 1,
    },
    {
      'title': 'Creamy milkshakes',
      'description': 'Lorem ipsum dolor sit amet, consectetur...',
      'price': 15.00,
      'rating': '4.8',
      'isNew': false,
      'image': 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500&q=80',
      'categoryIcon': Icons.local_drink_outlined,
      'quantity': 1,
    },
    {
      'title': 'Chicken Curry Rice Bowl',
      'description': 'Lorem ipsum dolor sit amet, consectetur...',
      'price': 18.00,
      'rating': '5.0',
      'isNew': false,
      'image': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500&q=80',
      'categoryIcon': Icons.restaurant_outlined,
      'quantity': 1,
    },
    {
      'title': 'Butter Chicken Bowl',
      'description': 'Lorem ipsum dolor sit amet, consectetur...',
      'price': 16.50,
      'rating': '4.9',
      'isNew': false,
      'image': 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?w=500&q=80',
      'categoryIcon': Icons.dinner_dining_outlined,
      'quantity': 1,
    },
  ];

  void _navigateToMealDetails(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(
          mealData: {
            'name': item['title'],
            'price': item['price'],
            'image': item['image'],
          },
        ),
      ),
    );
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      int currentQty = _recommendations[index]['quantity'];
      if (currentQty + delta >= 1) {
        _recommendations[index]['quantity'] = currentQty + delta;
      }
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
                    'Recommendations',
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

            // Content Area
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
                    const SizedBox(height: 16),
                    // Subtitle Text
                    const Text(
                      'Discover the dishes\nrecommended by the chef.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Scrollable List / Grid
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          children: [
                            // 1. Featured Top Banner Card (Hero Item - Crepes)
                            _buildHeroCard(0),

                            const SizedBox(height: 16),

                            // 2. Grid Items (2 Columns)
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _recommendations.length - 1,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.72,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 16,
                              ),
                              itemBuilder: (context, gridIndex) {
                                final itemIndex = gridIndex + 1;
                                return _buildGridCard(itemIndex);
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
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

  // Large Featured Horizontal Card Layout
  Widget _buildHeroCard(int index) {
    final item = _recommendations[index];
    return GestureDetector(
      onTap: () => _navigateToMealDetails(item),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Image Stack Container
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    item['image'],
                    width: 145,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 145,
                      height: 160,
                      color: AppColors.secondary,
                      child: const Icon(Icons.fastfood, color: AppColors.primary),
                    ),
                  ),
                ),
                // Top Left Icon Badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item['categoryIcon'], size: 14, color: AppColors.primary),
                  ),
                ),
                // Bottom Left Rating Tag
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item['rating'],
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(Icons.star, color: Colors.amber, size: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Item Details Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item['isNew'] == true)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'New Product',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      item['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${(item['price'] as double).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        _buildQuantityControls(index),
                      ],
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

  // Grid Vertical Card Layout
  Widget _buildGridCard(int index) {
    final item = _recommendations[index];
    return GestureDetector(
      onTap: () => _navigateToMealDetails(item),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container Stack
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    item['image'],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.secondary,
                      child: const Icon(Icons.fastfood, color: AppColors.primary),
                    ),
                  ),
                ),
                // Top Left Icon Badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item['categoryIcon'], size: 14, color: AppColors.primary),
                  ),
                ),
                // Bottom Left Rating
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item['rating'],
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(Icons.star, color: Colors.amber, size: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // Details
          Text(
            item['title'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          Text(
            item['description'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9,
              color: AppColors.textMuted,
            ),
          ),

          const SizedBox(height: 4),

          // Price & Controls Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${(item['price'] as double).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              _buildQuantityControls(index),
            ],
          ),
        ],
      ),
    );
  }

  // Minus / Counter / Plus / Cart Row
  Widget _buildQuantityControls(int index) {
    final qty = _recommendations[index]['quantity'] as int;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Minus Button
        GestureDetector(
          onTap: () => _updateQuantity(index, -1),
          child: Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: AppColors.accentYellow,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.remove, size: 12, color: AppColors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            '$qty',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ),
        // Plus Button
        GestureDetector(
          onTap: () => _updateQuantity(index, 1),
          child: Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, size: 12, color: AppColors.white),
          ),
        ),
        const SizedBox(width: 4),
        // Add to Cart Action Button
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.shopping_cart_outlined, size: 11, color: AppColors.white),
        ),
      ],
    );
  }
}