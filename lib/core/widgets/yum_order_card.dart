import 'package:flutter/material.dart';
import '../constants/colors.dart';

class YumOrderCard extends StatelessWidget {
  final String title;
  final String price;
  final String dateTime;
  final String itemCount;
  final String imagePath;

  final String? statusMessage;
  final IconData? statusIcon;
  final Color? statusColor;

  final String? primaryButtonText;
  final VoidCallback? onPrimaryTap;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryTap;

  const YumOrderCard({
    super.key,
    required this.title,
    required this.price,
    required this.dateTime,
    required this.itemCount,
    required this.imagePath,
    this.statusMessage,
    this.statusIcon,
    this.statusColor,
    this.primaryButtonText,
    this.onPrimaryTap,
    this.secondaryButtonText,
    this.onSecondaryTap,
  });

  Widget _buildImageWidget() {
    final bool isNetwork = imagePath.startsWith('http://') || imagePath.startsWith('https://');

    if (isNetwork) {
      return Image.network(
        imagePath,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallbackThumbnail(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildFallbackThumbnail(isLoading: true);
        },
      );
    }

    return Image.asset(
      imagePath,
      width: 80,
      height: 80,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildFallbackThumbnail(),
    );
  }

  Widget _buildFallbackThumbnail({bool isLoading = false}) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.accentYellow.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary,
          ),
        )
            : const Icon(
          Icons.fastfood_rounded,
          size: 38,
          color: AppColors.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary.withOpacity(0.15),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Image Container
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: _buildImageWidget(),
          ),
          const SizedBox(width: 12),

          // Details & Actions
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title.isEmpty ? 'Order Item' : title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateTime,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                    Text(
                      itemCount,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),

                // Status Message
                if (statusMessage != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        statusIcon ?? Icons.info_outline,
                        size: 14,
                        color: statusColor ?? AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        statusMessage!,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: statusColor ?? AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],

                // Action Buttons
                if (primaryButtonText != null || secondaryButtonText != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (primaryButtonText != null) ...[
                        InkWell(
                          onTap: onPrimaryTap,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              primaryButtonText!,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                      if (secondaryButtonText != null) ...[
                        InkWell(
                          onTap: onSecondaryTap,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accentYellow.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              secondaryButtonText!,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}