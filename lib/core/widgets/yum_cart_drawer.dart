import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../../features/cart_checkout/screens/confirm_order_screen.dart';

class YumCartDrawer extends StatefulWidget {
  const YumCartDrawer({super.key});

  @override
  State<YumCartDrawer> createState() => _YumCartDrawerState();
}

class _YumCartDrawerState extends State<YumCartDrawer> {
  // Sample Cart Items - update quantities or clear list to test empty state
  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'name': 'Strawberry\nShake',
      'price': 20.0,
      'dateTime': '29/11/24\n15:00',
      'quantity': 2,
      'image': 'https://picsum.photos/id/1080/200/200',
    },
    {
      'id': '2',
      'name': 'Broccoli\nLasagna',
      'price': 12.0,
      'dateTime': '29/11/24\n12:00',
      'quantity': 1,
      'image': 'https://picsum.photos/id/292/200/200',
    },
  ];

  final double _taxAndFees = 5.00;
  final double _delivery = 3.00;

  double get _subtotal {
    return _cartItems.fold(
      0.0,
          (sum, item) => sum + ((item['price'] as double) * (item['quantity'] as int)),
    );
  }

  double get _total => _subtotal + _taxAndFees + _delivery;

  void _updateQuantity(int index, int delta) {
    setState(() {
      _cartItems[index]['quantity'] = (_cartItems[index]['quantity'] as int) + delta;
      if (_cartItems[index]['quantity'] <= 0) {
        _cartItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width * 0.82;

    return Drawer(
      width: width,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            bottomLeft: Radius.circular(35),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Cart Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: const [
                    Icon(
                      Icons.shopping_cart,
                      color: AppColors.white,
                      size: 26,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Cart',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Divider(color: Colors.white30, height: 1),
              ),

              // Drawer Content (Empty vs Populated State)
              Expanded(
                child: _cartItems.isEmpty ? _buildEmptyCart() : _buildPopulatedCart(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- EMPTY CART STATE ---
  Widget _buildEmptyCart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Your cart is empty',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 40),

        // Plus Icon Outline Circle
        Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 2.5),
          ),
          child: const Icon(
            Icons.add,
            size: 48,
            color: AppColors.white,
          ),
        ),

        const SizedBox(height: 30),
        const Text(
          'Want To Add\nSomething?',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            height: 1.25,
          ),
        ),
      ],
    );
  }

  // --- POPULATED CART STATE ---
  Widget _buildPopulatedCart() {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          'You have ${_cartItems.length} items in the cart',
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),

        // Items List
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _cartItems.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.white30,
              height: 24,
            ),
            itemBuilder: (context, index) {
              final item = _cartItems[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Product Thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 60,
                        height: 60,
                        color: AppColors.accentYellow,
                        child: const Icon(Icons.fastfood, color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Name & Price
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${(item['price'] as double).toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Date/Time & Quantity Selector
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item['dateTime'],
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 9,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Quantity Selector Row
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => _updateQuantity(index, -1),
                            child: const Icon(
                              Icons.remove_circle,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              '${item['quantity']}',
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _updateQuantity(index, 1),
                            child: const Icon(
                              Icons.add_circle,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(color: Colors.white30, height: 1),
        ),
        const SizedBox(height: 16),

        // Bill Summary Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              _buildPriceRow('Subtotal', '\$${_subtotal.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              _buildPriceRow('Tax and Fees', '\$${_taxAndFees.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              _buildPriceRow('Delivery', '\$${_delivery.toStringAsFixed(2)}'),
              const SizedBox(height: 12),
              const Divider(color: Colors.white30, height: 1),
              const SizedBox(height: 12),
              _buildPriceRow('Total', '\$${_total.toStringAsFixed(2)}', isTotal: true),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Checkout Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                // Pop drawer before navigating to prevent drawer overlay on back press
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ConfirmOrderScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentYellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.white,
            fontSize: isTotal ? 14 : 12,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.white,
            fontSize: isTotal ? 14 : 12,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}