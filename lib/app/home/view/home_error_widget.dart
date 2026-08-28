import 'package:flutter/material.dart';
import 'package:jobs_fantastic/core/const/app_colors.dart';
import 'package:jobs_fantastic/core/const/app_text_styles.dart';
import 'package:jobs_fantastic/core/extension/sized_box_extension.dart';

class HomeErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const HomeErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 56,
              color: Colors.red.shade300,
            ),
            16.hSpace,
            Text('Something went wrong', style: AppTextStyles.bold16),
            6.hSpace,
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular14.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
            20.hSpace,
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
/// =====================================================
/// LOADING / EMPTY / ERROR STATES
/// =====================================================
class JobListSkeleton extends StatelessWidget {
  const JobListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: 5,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 56,
              color: Colors.grey.shade300,
            ),
            16.hSpace,
            Text('No jobs found', style: AppTextStyles.bold16),
            6.hSpace,
            Text(
              'Try adjusting your search or filters.',
              textAlign: TextAlign.center,
              style: AppTextStyles.regular14.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
