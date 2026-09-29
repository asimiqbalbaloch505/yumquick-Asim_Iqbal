import 'package:flutter/material.dart';
import 'yum_order_card.dart';
import '../../features/orders/screens/cancel_order_screen.dart';

class YumActiveOrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  final VoidCallback onOrderCancelled;

  const YumActiveOrderCard({
    super.key,
    required this.order,
    required this.onOrderCancelled,
  });

  @override
  Widget build(BuildContext context) {
    return YumOrderCard(
      title: order['title'] ?? '',
      price: order['price'] ?? '',
      dateTime: order['dateTime'] ?? '',
      itemCount: order['itemCount'] ?? '',
      imagePath: order['imagePath'] ?? '',
      primaryButtonText: 'Cancel Order',
      onPrimaryTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CancelOrderScreen(),
          ),
        );
        if (result == true) {
          onOrderCancelled();
        }
      },
      secondaryButtonText: 'Track Driver',
      onSecondaryTap: () {},
    );
  }
}