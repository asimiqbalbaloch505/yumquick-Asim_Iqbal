import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/yum_bottom_nav_bar.dart';
import '../../../core/widgets/yum_cart_drawer.dart';
import '../../../core/widgets/yum_best_seller_grid_card.dart';
import 'meal_details_screen.dart';

class BestSellerScreen extends StatefulWidget {
  const BestSellerScreen({super.key});

  @override
  State<BestSellerScreen> createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _bestSellers = [
    {
      'title': 'Sunny Bruschetta',
      'description': 'Lorem ipsum dolor sit amet, consectetur...',
      'price': '\$15.00',
      'numPrice': 15.00,
      'rating': '5.0',
      'image': 'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?w=500&q=80',
    },
    {
      'title': 'Gourmet Grilled Skewers',
      'description': 'Lorem ipsum dolor sit amet, consectetur...',
      'price': '\$12.00',
      'numPrice': 12.00,
      'rating': '4.5',
      'image': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=500&q=80',
    },
    {
      'title': 'Barbecue tacos',
      'description': 'Lorem ipsum dolor sit amet, consectetur...',
      'price': '\$15.00',
      'numPrice': 15.00,
      'rating': '4.0',
      'image': 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=500&q=80',
    },
    {
      'title': 'Broccoli lasagna',
      'description': 'Lorem ipsum dolor sit amet, consectetur...',
      'price': '\$12.00',
      'numPrice': 12.00,
      'rating': '3.5',
      'image': 'https://images.unsplash.com/photo-1619895092538-128341789043?w=500&q=80',
    },
    {
      'title': 'Mocha Coffee Float',
      'description': 'Lorem ipsum dolor sit amet, consectetur...',
      'price': '\$15.00',
      'numPrice': 15.00,
      'rating': '5.0',
      'image': 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&q=80',
    },
    {
      'title': 'Strawberry Cheesecake',
      'description': 'Lorem ipsum dolor sit amet, consectetur...',
      'price': '\$12.00',
      'numPrice': 12.00,
      'rating': '4.8',
      'image': 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=500&q=80',
    },
  ];

  void _navigateToMealDetails(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(
          mealData: {
            'name': item['title'],
            'price': item['numPrice'],
            'image': item['image'],
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondary,
      endDrawer: const YumCartDrawer(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const Text(
                    'Best Seller',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // White Main Body
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
                    const Text(
                      'Discover our most popular dishes!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Grid View of Best Sellers
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.72,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: _bestSellers.length,
                        itemBuilder: (context, index) {
                          final item = _bestSellers[index];
                          return YumBestSellerGridCard(
                            title: item['title'],
                            description: item['description'],
                            price: item['price'],
                            rating: item['rating'],
                            imagePath: item['image'],
                            onTap: () => _navigateToMealDetails(item),
                            onAddToCart: () {
                              _scaffoldKey.currentState?.openEndDrawer();
                            },
                          );
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
      bottomNavigationBar: YumBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index != 0) Navigator.of(context).pop();
        },
      ),
    );
  }
}