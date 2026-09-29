import 'package:flutter/material.dart';
import 'package:yumquick/core/constants/colors.dart';
import 'order_cancelled_success_screen.dart';

class CancelOrderScreen extends StatefulWidget {
  const CancelOrderScreen({super.key});

  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  int _selectedReasonIndex = 0;
  final TextEditingController _otherReasonController = TextEditingController();

  final List<String> _reasons = [
    'Lorem ipsum dolor sit amet',
    'Lorem ipsum dolor sit amet',
    'Lorem ipsum dolor sit amet',
    'Lorem ipsum dolor sit amet',
    'Lorem ipsum dolor sit amet',
  ];

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.primary),
                    ),
                  ),
                  const Text(
                    'Cancel Order',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Content Form
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Reasons List
                      ...List.generate(_reasons.length, (index) {
                        return _buildReasonOption(index, _reasons[index]);
                      }),

                      const SizedBox(height: 12),
                      const Text(
                        'Others',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Others Input Field
                      Container(
                        height: 90,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.accentYellow.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: _otherReasonController,
                          maxLines: 3,
                          style: const TextStyle(fontSize: 12, color: AppColors.textDark),
                          decoration: const InputDecoration(
                            hintText: 'Others reason...',
                            hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 11),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Submit Button
                      Center(
                        child: SizedBox(
                          width: 180,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () {
                              // Replaces CancelOrderScreen with OrderCancelledSuccessScreen
                              // and passes `true` back to MyOrdersScreen upon pop.
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OrderCancelledSuccessScreen(),
                                ),
                              ).then((_) {
                                if (context.mounted) {
                                  Navigator.pop(context, true);
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReasonOption(int index, String title) {
    final isSelected = _selectedReasonIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedReasonIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.primary.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.accentYellow,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}