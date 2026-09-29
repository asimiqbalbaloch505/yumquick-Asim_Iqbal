import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/config/routes.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/yum_button.dart';
import '../bloc/auth_bloc.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final _passwordController = TextEditingController(text: '************');
  final _confirmPasswordController = TextEditingController(text: '************');

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AuthBloc(),
        child: Scaffold(
          backgroundColor: AppColors.secondary, // Yellow top header background
          body: SafeArea(
            bottom: false,
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
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
                              'Set Password',
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

                    // 2. White Card Content Body
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
                              // Subtitle description text
                              const Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textMuted,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 28),

                              // New Password Input
                              _buildFieldLabel('Password'),
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

                              const SizedBox(height: 20),

                              // Confirm Password Input
                              _buildFieldLabel('Confirm Password'),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.accentYellow.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextField(
                                  controller: _confirmPasswordController,
                                  obscureText: _obscureConfirmPassword,
                                  style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                        color: AppColors.primary,
                                        size: 18,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureConfirmPassword = !_obscureConfirmPassword;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 40),

                              // Create New Password Action Button
                              Center(
                                child: state is AuthLoading
                                    ? const CircularProgressIndicator(color: AppColors.primary)
                                    : YumButton(
                                  text: 'Create New Password',
                                  width: 230,
                                  height: 45,
                                  backgroundColor: AppColors.primary,
                                  textColor: AppColors.white,
                                  borderRadius: 22,
                                  onPressed: () {
                                    if (_passwordController.text != _confirmPasswordController.text) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Passwords do not match')),
                                      );
                                      return;
                                    }

                                    // Navigate back to Login screen
                                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                                  },
                                ),
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

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}