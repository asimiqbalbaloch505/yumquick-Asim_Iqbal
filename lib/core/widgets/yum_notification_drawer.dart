import 'package:flutter/material.dart';
import '../constants/colors.dart';

class YumNotificationDrawer extends StatelessWidget {
  const YumNotificationDrawer({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Title Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: const [
                    Icon(
                      Icons.notifications,
                      color: AppColors.white,
                      size: 28,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Divider(color: Colors.white30, height: 1),
              ),

              // Notifications List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  children: const [
                    _NotificationTile(
                      icon: Icons.restaurant, // Fixed: using standard Flutter Icon
                      message: 'We have added\na product you\nmight like.',
                    ),
                    Divider(color: Colors.white30, height: 1),
                    _NotificationTile(
                      icon: Icons.favorite_border,
                      message: 'One of your\nfavorite is on\npromotion.',
                    ),
                    Divider(color: Colors.white30, height: 1),
                    _NotificationTile(
                      icon: Icons.shopping_bag_outlined,
                      message: 'Your order has\nbeen delivered',
                    ),
                    Divider(color: Colors.white30, height: 1),
                    _NotificationTile(
                      icon: Icons.delivery_dining,
                      message: 'The delivery is\non his way',
                    ),
                    Divider(color: Colors.white30, height: 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final IconData icon;
  final String message;

  const _NotificationTile({
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // White Circular Icon Container
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),

          // Message Text
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}