import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/yum_best_seller_card.dart';
import '../../../core/widgets/yum_cart_drawer.dart'; // Import Cart Drawer
import '../../../core/widgets/yum_category_item.dart';
import '../../../core/widgets/yum_notification_drawer.dart'; // Import Notification Drawer
import '../../../core/widgets/yum_profile_drawer.dart';
import '../../../core/widgets/yum_promo_banner.dart';
import '../../../core/widgets/yum_recommend_card.dart';
import 'best_seller_screen.dart'; // Import Best Seller Screen
import 'meal_details_screen.dart'; // Import Meal Details Screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget? _currentDrawer;

  void _openDrawer(Widget drawer) {
    setState(() {
      _currentDrawer = drawer;
    });
    _scaffoldKey.currentState?.openEndDrawer();
  }

  // Navigation helper to open MealDetailsScreen with product info
  void _navigateToMealDetails(String name, double price, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(
          mealData: {
            'name': name,
            'price': price,
            'image': imagePath,
          },
        ),
      ),
    );
  }

  // Navigation helper to open BestSellerScreen
  void _navigateToBestSeller() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BestSellerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondary,
      endDrawer: _currentDrawer ?? const YumNotificationDrawer(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar & Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Search',
                                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.tune, color: AppColors.white, size: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Cart Icon - Opens Cart Drawer
                      GestureDetector(
                        onTap: () => _openDrawer(const YumCartDrawer()),
                        child: _buildHeaderCircleIcon(Icons.shopping_cart_outlined),
                      ),
                      const SizedBox(width: 8),

                      // Notification Icon - Opens Notification Drawer
                      GestureDetector(
                        onTap: () => _openDrawer(const YumNotificationDrawer()),
                        child: _buildHeaderCircleIcon(Icons.notifications_none),
                      ),
                      const SizedBox(width: 8),

                      // Profile Icon - Opens Profile Drawer
                      GestureDetector(
                        onTap: () => _openDrawer(const YumProfileDrawer()),
                        child: _buildHeaderCircleIcon(Icons.person_outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Good Morning',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const Text(
                    'Rise And Shine! It\'s Breakfast Time',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Main Content Body
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Categories
                      SizedBox(
                        height: 75,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: const [
                            YumCategoryItem(
                              label: 'Snacks',
                              assetPath: 'assets/images/cat_snacks.png',
                              fallbackIcon: Icons.fastfood_outlined,
                            ),
                            YumCategoryItem(
                              label: 'Meal',
                              assetPath: 'assets/images/cat_meal.png',
                              fallbackIcon: Icons.restaurant_outlined,
                            ),
                            YumCategoryItem(
                              label: 'Vegan',
                              assetPath: 'assets/images/cat_vegan.png',
                              fallbackIcon: Icons.eco_outlined,
                            ),
                            YumCategoryItem(
                              label: 'Dessert',
                              assetPath: 'assets/images/cat_dessert.png',
                              fallbackIcon: Icons.cake_outlined,
                            ),
                            YumCategoryItem(
                              label: 'Drinks',
                              assetPath: 'assets/images/cat_drinks.png',
                              fallbackIcon: Icons.local_bar_outlined,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Best Seller Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Best Seller',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            GestureDetector(
                              onTap: _navigateToBestSeller,
                              child: Row(
                                children: const [
                                  Text(
                                    'View All',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(Icons.chevron_right, size: 16, color: AppColors.primary),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Best Seller Cards (Tapping navigates to MealDetailsScreen)
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            GestureDetector(
                              onTap: () => _navigateToMealDetails(
                                'Fresh Sushi Roll',
                                3.00,
                                'assets/images/sushi.png',
                              ),
                              child: const YumBestSellerCard(
                                assetPath: 'assets/images/sushi.png',
                                price: '\$03.0',
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _navigateToMealDetails(
                                'Japanese Curry Rice',
                                60.00,
                                'assets/images/curry.png',
                              ),
                              child: const YumBestSellerCard(
                                assetPath: 'assets/images/curry.png',
                                price: '\$60.0',
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _navigateToMealDetails(
                                'Broccoli Lasagna',
                                12.99,
                                'assets/images/lasagna.png',
                              ),
                              child: const YumBestSellerCard(
                                assetPath: 'assets/images/lasagna.png',
                                price: '\$12.99',
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _navigateToMealDetails(
                                'Sweet Vanilla Cupcake',
                                8.20,
                                'assets/images/cupcake.png',
                              ),
                              child: const YumBestSellerCard(
                                assetPath: 'assets/images/cupcake.png',
                                price: '\$8.20',
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Promo Banner (Tapping navigates to MealDetailsScreen)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () => _navigateToMealDetails(
                            'Special Gourmet Pizza',
                            24.50,
                            'assets/images/banner_pizza.png',
                          ),
                          child: const YumPromoBanner(
                            title: 'Experience our\ndelicious new dish',
                            discountText: '30% OFF',
                            imagePath: 'assets/images/banner_pizza.png',
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Banner Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildIndicator(false),
                          _buildIndicator(false),
                          _buildIndicator(true),
                          _buildIndicator(false),
                          _buildIndicator(false),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Recommend Header
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Recommend',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Recommend Cards (Tapping navigates to MealDetailsScreen)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _navigateToMealDetails(
                                  'Classic Beef Burger',
                                  10.00,
                                  'assets/images/burger.png',
                                ),
                                child: const YumRecommendCard(
                                  assetPath: 'assets/images/burger.png',
                                  rating: '5.0',
                                  price: '\$10.0',
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _navigateToMealDetails(
                                  'Crispy Spring Rolls',
                                  25.00,
                                  'assets/images/spring_rolls.png',
                                ),
                                child: const YumRecommendCard(
                                  assetPath: 'assets/images/spring_rolls.png',
                                  rating: '5.0',
                                  price: '\$25.0',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildHeaderCircleIcon(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: AppColors.primary),
    );
  }

  static Widget _buildIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: isActive ? 16 : 8,
      height: 4,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.accentYellow,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}