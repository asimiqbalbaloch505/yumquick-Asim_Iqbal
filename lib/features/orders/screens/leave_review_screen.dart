import 'package:flutter/material.dart';
import 'package:yumquick/app/config/routes.dart';
import 'package:yumquick/core/constants/colors.dart';
import 'package:yumquick/core/widgets/yum_bottom_nav_bar.dart';

class LeaveReviewScreen extends StatefulWidget {
  final String title;
  final String imageUrl;

  const LeaveReviewScreen({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
  int _selectedRating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      bottomNavigationBar: YumBottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.dashboard,
                (route) => false,
            arguments: index,
          );
        },
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const Text(
                    'Leave a Review',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Content Container
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          widget.imageUrl,
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 140,
                            height: 140,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.fastfood, size: 50, color: AppColors.primary),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Product Title
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 16),

                      // Subtitle Header Text
                      const Text(
                        "We'd love to know what you\nthink of your dish.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.textDark,
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Star Rating Selector
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final starNumber = index + 1;
                          final isFilled = starNumber <= _selectedRating;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRating = starNumber;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(
                                isFilled ? Icons.star : Icons.star_border_rounded,
                                size: 36,
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 24),

                      // Leave Us Your Comment Label
                      const Text(
                        'Leave us your comment!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Review Comment Text Box
                      Container(
                        height: 100,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.accentYellow.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: _reviewController,
                          maxLines: 4,
                          style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                          decoration: const InputDecoration(
                            hintText: 'Write Review...',
                            hintStyle: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 12,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Cancel & Submit Buttons
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 42,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.accentYellow.withOpacity(0.4),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 42,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Submit action
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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