import 'package:flutter/material.dart';
import 'package:jobs_fantastic/core/const/app_colors.dart';
import 'package:jobs_fantastic/core/const/app_text_styles.dart';
import 'package:jobs_fantastic/core/extension/sized_box_extension.dart';

class HomeHeader extends StatelessWidget {
  // final int? resultCount;
  // final bool isLoading;

  const HomeHeader({
    super.key,
    // this.resultCount,
    // this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutCubic,
                    tween: Tween(begin: 0, end: 18),
                    builder: (context, height, child) => Container(
                      width: 4,
                      height: height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primaryColor.withOpacity(0.4),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  8.wSpace,
                  Text(
                    'FIND YOUR NEXT OPPORTUNITY',
                    style: AppTextStyles.regular12.copyWith(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
              // _ResultBadge(count: resultCount, isLoading: isLoading),
            ],
          ),
          6.hSpace,
          Text(
            'Job Search',
            style: AppTextStyles.bold24.copyWith(
              fontSize: 28,
              height: 1.15,
              letterSpacing: -0.5,
            ),
          ),
          4.hSpace,
          Text(
            'Discover opportunities that match your skills.',
            style: AppTextStyles.regular12.copyWith(
              color: Colors.grey.shade600,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}