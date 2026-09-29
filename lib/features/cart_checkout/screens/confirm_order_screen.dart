import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/yum_bottom_nav_bar.dart';
import 'payment_screen.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final List<Map<String, dynamic>> _orderItems = [
    {
      'id': '1',
      'name': 'Strawberry Shake',
      'dateTime': '29 Nov, 15:20 pm',
      'price': 20.00,
      'quantity': 2,
      'image': 'https://picsum.photos/id/1080/200/200',
    },
    {
      'id': '2',
      'name': 'Broccoli Lasagna',
      'dateTime': '29 Nov, 12:00 pm',
      'price': 12.99,
      'quantity': 1,
      'image': 'https://picsum.photos/id/292/200/200',
    },
  ];

  final double _taxAndFees = 5.00;
  final double _delivery = 3.00;

  double get _subtotal {
    return _orderItems.fold(
      0.0,
          (sum, item) => sum + ((item['price'] as double) * (item['quantity'] as int)),
    );
  }

  double get _total => _subtotal + _taxAndFees + _delivery;

  void _updateQuantity(int index, int delta) {
    setState(() {
      _orderItems[index]['quantity'] = (_orderItems[index]['quantity'] as int) + delta;
      if (_orderItems[index]['quantity'] <= 0) {
        _orderItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary, // Yellow header area background
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Confirm Order',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance out back button
                ],
              ),
            ),

            const SizedBox(height: 10),

            // White Rounded Body Container
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Shipping Address Section
                      Row(
                        children: const [
                          Text(
                            'Shipping Address',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.edit_outlined, size: 16, color: AppColors.primary),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBE8A6), // Soft light yellow container
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          '778 Locust View Drive Oakland, CA',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Order Summary Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Order Summary',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE3D3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Order Items List
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _orderItems.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final item = _orderItems[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.network(
                                  item['image'],
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 70,
                                    height: 70,
                                    color: AppColors.secondary,
                                    child: const Icon(Icons.fastfood, color: AppColors.primary),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Item Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      item['dateTime'],
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Cancel Order Chip
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFE3D3),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        'Cancel Order',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Price & Controls
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(Icons.delete_outline, size: 16, color: AppColors.primary),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${(item['price'] as double).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    '${item['quantity']} items',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  // Quantity Counter Row
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.edit_outlined, size: 14, color: AppColors.primary),
                                      const SizedBox(width: 4),
                                      GestureDetector(
                                        onTap: () => _updateQuantity(index, -1),
                                        child: const Icon(Icons.remove_circle, size: 18, color: AppColors.primary),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 6),
                                        child: Text(
                                          '${item['quantity']}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textDark,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _updateQuantity(index, 1),
                                        child: const Icon(Icons.add_circle, size: 18, color: AppColors.primary),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Totals breakdown
                      _buildSummaryRow('Subtotal', '\$${_subtotal.toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Tax and Fees', '\$${_taxAndFees.toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Delivery', '\$${_delivery.toStringAsFixed(2)}'),
                      const SizedBox(height: 12),
                      const Divider(color: Colors.black12, height: 1),
                      const SizedBox(height: 12),
                      _buildSummaryRow('Total', '\$${_total.toStringAsFixed(2)}', isTotal: true),

                      const SizedBox(height: 24),

                      // Place Order Button
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PaymentScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFE3D3),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          child: const Text(
                            'Place Order',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: YumBottomNavBar(
        currentIndex: 3, // Highlights the 'Orders' tab
        onTap: (index) {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildSummaryRow(String title, String price, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}