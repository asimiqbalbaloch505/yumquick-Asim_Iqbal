import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/yum_active_order_card.dart';
import '../../../core/widgets/yum_cancelled_order_card.dart';
import '../../../core/widgets/yum_completed_order_card.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _selectedTabIndex = 0; // 0: Active, 1: Completed, 2: Cancelled

  final List<Map<String, dynamic>> _orders = [
    // Active Orders
    {
      'id': '1',
      'title': 'Strawberry Shake',
      'price': '\$20.00',
      'dateTime': '29 Nov, 01:20 pm',
      'itemCount': '2 items',
      'status': 'active',
      'imagePath': 'https://picsum.photos/id/1080/200/200',
    },
    // Completed Orders
    {
      'id': '2',
      'title': 'Chicken Curry',
      'price': '\$50.00',
      'dateTime': '29 Nov, 01:20 pm',
      'itemCount': '2 items',
      'status': 'completed',
      'imagePath': 'https://picsum.photos/id/292/200/200',
    },
    {
      'id': '3',
      'title': 'Bean and Vegetable Burger',
      'price': '\$50.00',
      'dateTime': '10 Nov, 06:05 pm',
      'itemCount': '2 items',
      'status': 'completed',
      'imagePath': 'https://picsum.photos/id/1060/200/200',
    },
    {
      'id': '4',
      'title': 'Coffee Latte',
      'price': '\$8.00',
      'dateTime': '10 Nov, 08:30 am',
      'itemCount': '1 item',
      'status': 'completed',
      'imagePath': 'https://picsum.photos/id/763/200/200',
    },
    {
      'id': '5',
      'title': 'Strawberry Cheesecake',
      'price': '\$22.00',
      'dateTime': '03 Oct, 03:40 pm',
      'itemCount': '2 items',
      'status': 'completed',
      'imagePath': 'https://picsum.photos/id/102/200/200',
    },
    // Cancelled Orders
    {
      'id': '6',
      'title': 'Sushi Wave Roll',
      'price': '\$45.00',
      'dateTime': '02 Nov, 04:00 pm',
      'itemCount': '3 items',
      'status': 'cancelled',
      'imagePath': 'https://picsum.photos/id/429/200/200',
    },
    {
      'id': '7',
      'title': 'Fruit and Berry Tea',
      'price': '\$15.00',
      'dateTime': '12 Oct, 03:15 pm',
      'itemCount': '2 items',
      'status': 'cancelled',
      'imagePath': 'https://picsum.photos/id/225/200/200',
    },
    {
      'id': '8',
      'title': 'Pepperoni Pizza',
      'price': '\$32.00',
      'dateTime': '01 Oct, 07:20 pm',
      'itemCount': '1 item',
      'status': 'cancelled',
      'imagePath': 'https://picsum.photos/id/1080/200/200',
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    switch (_selectedTabIndex) {
      case 0:
        return _orders.where((o) => o['status'] == 'active').toList();
      case 1:
        return _orders.where((o) => o['status'] == 'completed').toList();
      case 2:
        return _orders.where((o) => o['status'] == 'cancelled').toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredOrders;

    return Scaffold(
      backgroundColor: AppColors.secondary,
      // Removed redundant YumBottomNavBar to prevent duplicate bottom bar
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const Text(
                    'My Orders',
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

            // Main Content Sheet
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

                    // Tab Navigation
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          _buildTabItem('Active', 0),
                          const SizedBox(width: 10),
                          _buildTabItem('Completed', 1),
                          const SizedBox(width: 10),
                          _buildTabItem('Cancelled', 2),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Orders List
                    Expanded(
                      child: filtered.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final order = filtered[index];
                          if (_selectedTabIndex == 0) {
                            return YumActiveOrderCard(
                              order: order,
                              onOrderCancelled: () {
                                setState(() {
                                  order['status'] = 'cancelled';
                                });
                              },
                            );
                          } else if (_selectedTabIndex == 1) {
                            return YumCompletedOrderCard(order: order);
                          } else {
                            return YumCancelledOrderCard(order: order);
                          }
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

  Widget _buildTabItem(String label, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : AppColors.accentYellow.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final tabName = _selectedTabIndex == 0
        ? 'active'
        : _selectedTabIndex == 1
        ? 'completed'
        : 'cancelled';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: AppColors.accentYellow.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              size: 55,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'You don\'t have any $tabName orders at this time',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}