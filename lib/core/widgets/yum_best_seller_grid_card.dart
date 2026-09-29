import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class YumBestSellerGridCard extends StatefulWidget {
  final String title;
  final String description;
  final String price;
  final String rating;
  final String imagePath;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const YumBestSellerGridCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.imagePath,
    this.onTap,
    this.onAddToCart,
  });

  @override
  State<YumBestSellerGridCard> createState() => _YumBestSellerGridCardState();
}

class _YumBestSellerGridCardState extends State<YumBestSellerGridCard> {
  bool _isFavorite = false;

  Widget _buildProductImage(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(
        path,
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildFallbackImage(),
      );
    } else {
      return Image.asset(
        path,
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildFallbackImage(),
      );
    }
  }

  // Fallback network image with high-quality food visuals
  Widget _buildFallbackImage() {
    return Image.network(
      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500&q=80',
      height: 120,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        height: 120,
        width: double.infinity,
        color: AppColors.secondary,
        child: const Icon(Icons.fastfood, size: 40, color: AppColors.primary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack Container with Overlay Icons
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _buildProductImage(widget.imagePath),
                ),
                // Left Icon Badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      size: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                // Favorite Heart Button
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 14,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                // Price Tag Overlay
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.price,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Product Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 9,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Rating Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.rating,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(Icons.star, color: Colors.amber, size: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Cart Button
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 8),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: widget.onAddToCart,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 14,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}