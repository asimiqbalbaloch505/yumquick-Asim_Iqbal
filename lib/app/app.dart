import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/constants/colors.dart';
import 'config/navigation_bloc.dart';
import 'config/routes.dart';

class YumQuickApp extends StatelessWidget {
  const YumQuickApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationBloc()),
      ],
      child: MaterialApp(
        title: 'YumQuick',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          primaryColor: AppColors.primary,
          useMaterial3: true,
        ),
        // Changed initialRoute from AppRoutes.login to AppRoutes.splash
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      ),
    );
  }
}