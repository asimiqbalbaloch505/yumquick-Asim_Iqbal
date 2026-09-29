import 'package:flutter/material.dart';
import '../constants/colors.dart';

class YumProfileDrawer extends StatelessWidget {
  const YumProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 24, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                // Profile Header
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage('assets/images/user_profile.jpg'),
                      backgroundColor: AppColors.white,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'John Smith',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Loremipsum@email.com',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 11,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Menu Items
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildMenuItem(Icons.shopping_bag_outlined, 'My Orders', onTap: () {}),
                      _buildDivider(),
                      _buildMenuItem(Icons.person_outline, 'My Profile', onTap: () {}),
                      _buildDivider(),
                      _buildMenuItem(Icons.location_on_outlined, 'Delivery Address', onTap: () {}),
                      _buildDivider(),
                      _buildMenuItem(Icons.credit_card_outlined, 'Payment Methods', onTap: () {}),
                      _buildDivider(),
                      _buildMenuItem(Icons.phone_in_talk_outlined, 'Contact Us', onTap: () {}),
                      _buildDivider(),
                      _buildMenuItem(Icons.chat_bubble_outline, 'Help & FAQs', onTap: () {}),
                      _buildDivider(),
                      _buildMenuItem(Icons.settings_outlined, 'Settings', onTap: () {}),

                      const SizedBox(height: 32),

                      _buildMenuItem(Icons.logout_rounded, 'Log Out', onTap: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.primary, size: 18),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: AppColors.white.withOpacity(0.2),
      height: 1,
      thickness: 1,
    );
  }
}