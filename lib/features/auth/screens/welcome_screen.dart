import 'package:flutter/material.dart';

import '../../../app/config/routes.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/yum_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity, // Ensures full screen width centering
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Centers all children horizontally
              children: [
                const Spacer(flex: 3),

                Image.asset(
                  'assets/images/Group 270.png',
                  width: 210,
                  color: AppColors.secondary,
                  colorBlendMode: BlendMode.srcIn,
                ),

                const SizedBox(height: 24),

                const Text(
                  'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),

                const Spacer(flex: 3),

                YumButton(
                  text: 'Log In',
                  width: 207,
                  height: 45,
                  backgroundColor: AppColors.accentYellow,
                  textColor: AppColors.primary,
                  borderRadius: 25,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                ),

                const SizedBox(height: 14),

                YumButton(
                  text: 'Sign Up',
                  width: 207,
                  height: 45,
                  backgroundColor: AppColors.background,
                  textColor: AppColors.primary,
                  borderRadius: 25,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signup);
                  },
                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}