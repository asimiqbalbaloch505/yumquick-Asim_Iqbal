import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/config/routes.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/yum_button.dart';
import '../bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController(text: 'example@example.com');
  final _passwordController = TextEditingController(text: '************');
  final _emailController = TextEditingController(text: 'example@example.com');
  final _mobileController = TextEditingController(text: '+ 123 456 789');
  final _dobController = TextEditingController(text: 'DD / MM /YYY');

  bool _obscurePassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: Scaffold(
        backgroundColor: AppColors.secondary, // Top yellow header background
        body: SafeArea(
          bottom: false,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                // Navigate to Set Fingerprint Screen after account creation
                Navigator.pushReplacementNamed(context, AppRoutes.setFingerprint);
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
                            'New Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48), // Balance back button alignment
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
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Full Name Input
                            _buildFieldLabel('Full name'),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.accentYellow.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.blue, width: 1.5),
                              ),
                              child: TextField(
                                controller: _fullNameController,
                                style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Password Input
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
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

                            const SizedBox(height: 14),

                            // Email Input
                            _buildFieldLabel('Email'),
                            _buildCustomTextField(_emailController),

                            const SizedBox(height: 14),

                            // Mobile Number Input
                            _buildFieldLabel('Mobile Number'),
                            _buildCustomTextField(_mobileController),

                            const SizedBox(height: 14),

                            // Date of Birth Input
                            _buildFieldLabel('Date of birth'),
                            _buildCustomTextField(_dobController),

                            const SizedBox(height: 16),

                            // Terms & Privacy Policy Text
                            Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                                  children: [
                                    TextSpan(text: 'By continuing, you agree to\n'),
                                    TextSpan(
                                      text: 'Terms of Use',
                                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
                                    ),
                                    TextSpan(text: ' and '),
                                    TextSpan(
                                      text: 'Privacy Policy.',
                                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Sign Up Action Button
                            Center(
                              child: state is AuthLoading
                                  ? const CircularProgressIndicator(color: AppColors.primary)
                                  : YumButton(
                                text: 'Sign Up',
                                width: 220,
                                height: 45,
                                backgroundColor: AppColors.primary,
                                textColor: AppColors.white,
                                borderRadius: 22,
                                onPressed: () {
                                  context.read<AuthBloc>().add(
                                    SignUpSubmitted(
                                      _fullNameController.text,
                                      _emailController.text,
                                      _passwordController.text,
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Social Sign-up Label
                            const Center(
                              child: Text(
                                'or sign up with',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Social PNG Icons
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

                            const SizedBox(height: 16),

                            // Redirect to Login Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Text(
                                    'Log in',
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

                  // 3. Bottom Navigation Bar Frame
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
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
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

  Widget _buildCustomTextField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.accentYellow.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 13, color: AppColors.textDark),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
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