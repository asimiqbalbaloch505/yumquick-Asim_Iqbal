import 'package:flutter/material.dart';
import '../constants/colors.dart';

class YumCategoryItem extends StatelessWidget {
  final String label;
  final String assetPath;
  final IconData fallbackIcon;
  final VoidCallback? onTap;

  const YumCategoryItem({
    super.key,
    required this.label,
    required this.assetPath,
    this.fallbackIcon = Icons.fastfood_outlined,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.accentYellow.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  assetPath,
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(fallbackIcon, size: 22, color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: AppColors.textDark),
            ),
          ],
        ),
      ),
    );
  }
}