import 'package:flutter/material.dart';
import 'package:jobs_fantastic/core/const/app_colors.dart';
import 'package:jobs_fantastic/core/const/app_text_styles.dart';

/// --------------------------------------------
/// Chip Widget
/// --------------------------------------------
class ChipWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ChipWidget({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? AppColors.primaryColor : Colors.grey.shade300,
            ),
          ),
          child: Text(
            label,
            style: AppTextStyles.regular12.copyWith(
              color: selected ? Colors.white : Colors.grey.shade700,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
