import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/config/routes.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/yum_button.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'example@example.com');
  final _passwordController = TextEditingController(text: '************');
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AuthBloc(),
        child: Scaffold(
          backgroundColor: AppColors.secondary, // Top yellow header background from Figma
          body: SafeArea(
            bottom: false,
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return Column(
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
                              'Log In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 48), // Spacer to balance back button
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 2. Main Body Container
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
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Welcome',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textMuted,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 28),

                              // Email or Mobile Input
                              const Text(
                                'Email or Mobile Number',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.accentYellow.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextField(
                                  controller: _emailController,
                                  style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Password Input
                              const Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.accentYellow.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                        color: AppColors.primary,
                                        size: 18,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),

                              // Forget Password Link
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => Navigator.pushNamed(context, AppRoutes.setPassword),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 8, bottom: 20),
                                    child: Text(
                                      'Forget Password',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Log In Action Button
                              Center(
                                child: state is AuthLoading
                                    ? const CircularProgressIndicator(color: AppColors.primary)
                                    : YumButton(
                                  text: 'Log In',
                                  width: 220,
                                  height: 45,
                                  backgroundColor: AppColors.primary,
                                  textColor: AppColors.white,
                                  borderRadius: 22,
                                  onPressed: () {
                                    context.read<AuthBloc>().add(
                                      LoginSubmitted(
                                        _emailController.text,
                                        _passwordController.text,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Divider Text
                              const Center(
                                child: Text(
                                  'or sign up with',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Social Sign-in Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildSocialCircle('assets/images/ic_google.png', () {}),
                                  const SizedBox(width: 12),
                                  _buildSocialCircle('assets/images/ic_facebook.png', () {}),
                                  const SizedBox(width: 12),
                                  _buildSocialCircle('assets/images/ic_fingerprint.png', () {}),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Sign Up Redirect Text
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.pushNamed(context, AppRoutes.signup),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
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

                    // 3. Bottom Bar Accent
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
                );
              },
            ),
          ),
        ));
    }

  Widget _buildSocialCircle(String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.accentYellow.withOpacity(0.4),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.image_not_supported_outlined,
              size: 16,
              color: AppColors.primary,
            );
          },
        ),
      ),
    );
  }
}