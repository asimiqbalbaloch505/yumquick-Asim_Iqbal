import 'package:flutter/material.dart';
import 'yum_order_card.dart';

class YumCancelledOrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const YumCancelledOrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return YumOrderCard(
      title: order['title'] ?? '',
      price: order['price'] ?? '',
      dateTime: order['dateTime'] ?? '',
      itemCount: order['itemCount'] ?? '',
      imagePath: order['imagePath'] ?? '',
      statusMessage: 'Order cancelled',
      statusIcon: Icons.cancel_outlined,
      statusColor: Colors.redAccent,
    );
  }
}