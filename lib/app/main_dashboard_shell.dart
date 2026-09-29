import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/widgets/yum_bottom_nav_bar.dart';
import '../features/home/screens/favorites_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/home/screens/recommendations_screen.dart';
import '../features/orders/screens/my_orders_screen.dart';
import '../features/support/screens/help_screen.dart';
import 'config/navigation_bloc.dart';

class MainDashboardShell extends StatelessWidget {
  const MainDashboardShell({super.key});

  static const List<Widget> _pages = [
    HomeScreen(),
    RecommendationsScreen(),
    FavoritesScreen(),
    MyOrdersScreen(),
    HelpScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.tabIndex,
            children: _pages,
          ),
          bottomNavigationBar: YumBottomNavBar(
            currentIndex: state.tabIndex,
            onTap: (index) {
              context.read<NavigationBloc>().add(TabChanged(index));
            },
          ),
        );
      },
    );
  }
}