import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // 👈 Import flutter_svg

import '../../../app/config/routes.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/yum_button.dart';

class OnboardingItem {
  final String imagePath;
  final String iconPath;
  final String title;
  final String description;

  const OnboardingItem({
    required this.imagePath,
    required this.iconPath,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingItem> _items = const [
    OnboardingItem(
      imagePath: 'assets/images/onboarding_1.png',
      iconPath: 'assets/images/ic_order.svg',
      title: 'Order For Food',
      description:
      'Lorem ipsum dolor sit amet, conse ctetur\nadipiscing elit, sed do eiusmod tempor\nincididunt ut labore et dolore magna.',
    ),
    OnboardingItem(
      imagePath: 'assets/images/onboarding_2.png',
      iconPath: 'assets/images/ic_payment.svg',
      title: 'Easy Payment',
      description:
      'Lorem ipsum dolor sit amet, conse ctetur\nadipiscing elit, sed do eiusmod tempor\nincididunt ut labore et dolore magna.',
    ),
    OnboardingItem(
      imagePath: 'assets/images/onboarding_3.png',
      iconPath: 'assets/images/ic_delivery.svg',
      title: 'Fast Delivery',
      description:
      'Lorem ipsum dolor sit amet, conse ctetur\nadipiscing elit, sed do eiusmod tempor\nincididunt ut labore et dolore magna.',
    ),
  ];

  void _onNextPressed() {
    if (_currentIndex < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToWelcome();
    }
  }

  void _navigateToWelcome() {
    Navigator.pushReplacementNamed(context, AppRoutes.welcome);
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentIndex == _items.length - 1;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // 1. Food Header Image Carousel
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.58,
                width: double.infinity,
                child: Image.asset(
                  _items[index].imagePath,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.58,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              );
            },
          ),

          // 2. Skip Button Top Right
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 12, right: 20),
                child: GestureDetector(
                  onTap: _navigateToWelcome,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Skip',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 11,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. Rounded Bottom White Card Overlay
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.46,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                children: [
                  const SizedBox(height: 6),

                  // Feature SVG Icon
                  SvgPicture.asset(
                    _items[_currentIndex].iconPath,
                    height: 42,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Title
                  Text(
                    _items[_currentIndex].title,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Description Body
                  Text(
                    _items[_currentIndex].description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),

                  const Spacer(),

                  // Page Indicator Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _items.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 5,
                        width: _currentIndex == index ? 22 : 12,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? AppColors.primary
                              : AppColors.accentYellow,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Action Button ("Next" or "Get Started")
                  YumButton(
                    text: isLastPage ? 'Get Started' : 'Next',
                    width: 200,
                    height: 44,
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white,
                    borderRadius: 22,
                    onPressed: _onNextPressed,
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}