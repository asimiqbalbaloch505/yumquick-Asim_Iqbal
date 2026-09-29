import 'package:flutter/material.dart';
import 'yum_order_card.dart';
import '../../features/orders/screens/leave_review_screen.dart';

class YumCompletedOrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const YumCompletedOrderCard({
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
      statusMessage: 'Order delivered',
      statusIcon: Icons.check_circle_outline,
      primaryButtonText: 'Leave a review',
      onPrimaryTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeaveReviewScreen(
              title: order['title'] ?? '',
              imageUrl: order['imagePath'] ?? '',
            ),
          ),
        );
      },
      secondaryButtonText: 'Order Again',
      onSecondaryTap: () {},
    );
  }
}