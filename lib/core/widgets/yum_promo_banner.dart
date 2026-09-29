import 'package:flutter/material.dart';
import '../constants/colors.dart';

class YumPromoBanner extends StatelessWidget {
  final String title;
  final String discountText;
  final String imagePath;
  final VoidCallback? onTap;

  const YumPromoBanner({
    super.key,
    required this.title,
    required this.discountText,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      discountText,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: AppColors.accentYellow),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}