import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/yum_bottom_nav_bar.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Delivery time',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Main Content Container
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Address Title
                      const Text(
                        'Shipping Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBE8A6),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          '778 Locust View Drive Oaklanda, CA',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Map Placeholder Graphic
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 160,
                          width: double.infinity,
                          color: const Color(0xFFE2F1E7),
                          child: Stack(
                            children: [
                              CustomPaint(
                                size: Size.infinite,
                                painter: _MapPainter(),
                              ),
                              Positioned(
                                top: 30,
                                left: 60,
                                child: const Icon(Icons.location_on, color: AppColors.primary, size: 22),
                              ),
                              Positioned(
                                bottom: 40,
                                right: 70,
                                child: const Icon(Icons.location_on, color: AppColors.primary, size: 22),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Delivery Time Section
                      const Text(
                        'Delivery Time',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Estimated Delivery',
                            style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                          ),
                          Text(
                            '25 mins',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Timeline Steps
                      _buildTimelineStep('Your order has been accepted', '2 min', isCompleted: true),
                      _buildTimelineStep('The restaurant is preparing your order', '5 min', isCompleted: true),
                      _buildTimelineStep('The delivery is on his way', '10 min', isCompleted: false),
                      _buildTimelineStep('Your order has been delivered', '8 min', isCompleted: false, isLast: true),

                      const SizedBox(height: 24),

                      // Action Buttons Row
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFE3D3),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'Return Home',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'Track Order',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: YumBottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  Widget _buildTimelineStep(String text, String duration, {required bool isCompleted, bool isLast = false}) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? AppColors.primary : Colors.grey.shade400,
              ),
            ),
            if (!isLast)
              Container(
                width: 1.5,
                height: 22,
                color: Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          duration,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}

// Simple Map Background Painter for Mockup Visual
class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height * 0.4)
      ..lineTo(size.width * 0.3, size.height * 0.2)
      ..lineTo(size.width * 0.5, size.height * 0.6)
      ..lineTo(size.width, size.height * 0.3);

    canvas.drawPath(path, paint);

    final routePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final routePath = Path()
      ..moveTo(70, 40)
      ..lineTo(size.width * 0.5, 40)
      ..lineTo(size.width * 0.5, 120)
      ..lineTo(size.width - 80, 120);

    canvas.drawPath(routePath, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}