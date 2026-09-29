import 'package:flutter/material.dart';

import '../../../app/config/routes.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/yum_button.dart';

class SetFingerprintScreen extends StatefulWidget {
  const SetFingerprintScreen({super.key});

  @override
  State<SetFingerprintScreen> createState() => _SetFingerprintScreenState();
}

class _SetFingerprintScreenState extends State<SetFingerprintScreen> {
  bool _isFingerprintScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary, // Yellow top header background
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 1. Top Header Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Set Your Fingerprint',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance back button spacer
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 2. White Sheet Body Content
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
                  child: Column(
                    children: [
                      // Subtitle Description Text
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                      ),

                      const Spacer(),

                      // Fingerprint Tap Target
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isFingerprintScanned = !_isFingerprintScanned;
                          });
                        },
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: _isFingerprintScanned ? 1.0 : 0.35,
                          child: Image.asset(
                            'assets/images/ic_fingerprint_large.png',
                            height: 220,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback Flutter Icon if image asset isn't added yet
                              return Icon(
                                Icons.fingerprint,
                                size: 220,
                                color: AppColors.primary.withOpacity(
                                  _isFingerprintScanned ? 1.0 : 0.35,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Action Buttons (Skip & Continue)
                      Row(
                        children: [
                          Expanded(
                            child: YumButton(
                              text: 'Skip',
                              height: 44,
                              backgroundColor: AppColors.accentYellow.withOpacity(0.5),
                              textColor: AppColors.primary,
                              borderRadius: 22,
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: YumButton(
                              text: 'Continue',
                              height: 44,
                              backgroundColor: AppColors.primary,
                              textColor: AppColors.white,
                              borderRadius: 22,
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                                },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),

            // 3. Bottom Bar Preview Frame
            Container(
              height: 55,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.home_outlined, color: AppColors.white, size: 22),
                  Icon(Icons.restaurant_outlined, color: AppColors.white, size: 22),
                  Icon(Icons.favorite_border, color: AppColors.white, size: 22),
                  Icon(Icons.receipt_long_outlined, color: AppColors.white, size: 22),
                  Icon(Icons.headset_mic_outlined, color: AppColors.white, size: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}