import 'package:flutter/material.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/auth/screens/set_fingerprint_screen.dart';
import '../../features/auth/screens/set_password_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/welcome_screen.dart';
import '../../features/orders/screens/order_cancelled_success_screen.dart';
import '../main_dashboard_shell.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String setPassword = '/set-password';
  static const String setFingerprint = '/set-fingerprint';
  static const String dashboard = '/dashboard';
  static const String orderCancelledSuccess = '/order-cancelled-success';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    welcome: (context) => const WelcomeScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignUpScreen(),
    setPassword: (context) => const SetPasswordScreen(),
    setFingerprint: (context) => const SetFingerprintScreen(),
    dashboard: (context) => const MainDashboardShell(),
    orderCancelledSuccess: (context) => const OrderCancelledSuccessScreen(),
  };
}