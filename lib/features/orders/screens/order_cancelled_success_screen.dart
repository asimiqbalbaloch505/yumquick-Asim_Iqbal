import 'package:flutter/material.dart';
import 'package:yumquick/app/config/routes.dart';
import 'package:yumquick/core/constants/colors.dart';
import 'package:yumquick/core/widgets/yum_bottom_nav_bar.dart';

class OrderCancelledSuccessScreen extends StatefulWidget {
  const OrderCancelledSuccessScreen({super.key});

  @override
  State<OrderCancelledSuccessScreen> createState() =>
      _OrderCancelledSuccessScreenState();
}

class _OrderCancelledSuccessScreenState
    extends State<OrderCancelledSuccessScreen> {
  int _currentIndex = 3; // Orders tab active index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      bottomNavigationBar: YumBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Navigates back to MainDashboardShell and passes the selected tab index as an argument
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.dashboard,
                (route) => false,
            arguments: index,
          );
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Back Arrow
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Align(
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
            ),

            // Main Content Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // Custom Cancelled Face Icon
                    const CustomCancelledIcon(size: 110),

                    const SizedBox(height: 28),

                    // Title Text
                    const Text(
                      '¡Order Cancelled!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Subtitle Text
                    const Text(
                      'Your order has been successfully\ncancelled',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textDark,
                        height: 1.4,
                      ),
                    ),

                    const Spacer(flex: 3),

                    // Customer Support Note
                    const Text(
                      'If you have any question reach directly to our\ncustomer support',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textDark,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCancelledIcon extends StatelessWidget {
  final double size;

  const CustomCancelledIcon({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CancelledIconPainter(),
    );
  }
}

class _CancelledIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    final fillPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 3;

    // Draw Outer Circle
    canvas.drawCircle(center, radius, strokePaint);

    // Draw Left Eye Dot
    final leftEyeOffset = Offset(size.width * 0.35, size.height * 0.4);
    canvas.drawCircle(leftEyeOffset, 6, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}