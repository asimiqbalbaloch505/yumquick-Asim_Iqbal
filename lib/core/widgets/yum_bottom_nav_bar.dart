import 'package:flutter/material.dart';

import '../constants/colors.dart';

class YumBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const YumBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<String> _navIcons = [
    'assets/images/ic_home.png',
    'assets/images/ic_dish.png',
    'assets/images/ic_favorite.png',
    'assets/images/ic_orders.png',
    'assets/images/ic_support.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_navIcons.length, (index) {
          final isSelected = currentIndex == index;
          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 1.0 : 0.6,
                child: Image.asset(
                  _navIcons[index],
                  width: 22,
                  height: 22,
                  color: AppColors.white,
                  errorBuilder: (context, error, stackTrace) {
                    final fallbackIcons = [
                      Icons.home_outlined,
                      Icons.restaurant_outlined,
                      Icons.favorite_border,
                      Icons.receipt_long_outlined,
                      Icons.headset_mic_outlined,
                    ];
                    return Icon(
                      fallbackIcons[index],
                      color: AppColors.white,
                      size: 22,
                    );
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}