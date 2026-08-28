import 'package:flutter/material.dart';
import 'package:jobs_fantastic/app/home/data/model/job_model.dart';
import 'package:jobs_fantastic/core/const/app_colors.dart';
import 'package:jobs_fantastic/core/const/app_text_styles.dart';
import 'package:jobs_fantastic/core/extension/sized_box_extension.dart';

class JobCard extends StatelessWidget {
  final JobListing job;
  final VoidCallback onTap;
  final VoidCallback onSave;
  final bool isSaved;

  const JobCard({
    super.key,
    required this.job,
    required this.onTap,
    required this.onSave,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row: logo + title/org + save button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CompanyLogo(
                      logoUrl: job.organizationLogo,
                      name: job.organization,
                    ),
                    12.wSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title,
                            style: AppTextStyles.bold16,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          2.hSpace,
                          Text(
                            job.organization,
                            style: AppTextStyles.regular14.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onSave,
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: isSaved
                            ? AppColors.secondaryColor
                            : Colors.grey.shade400,
                      ),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),

                12.hSpace,

                // Location + work arrangement row
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 15,
                      color: Colors.grey.shade500,
                    ),
                    4.wSpace,
                    Expanded(
                      child: Text(
                        job.locationsDerived?.first ?? 'Location not specified',
                        style: AppTextStyles.regular12.copyWith(
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (job.workArrangement != null) ...[
                      8.wSpace,
                      _WorkArrangementBadge(type: job.workArrangement!),
                    ],
                  ],
                ),

                12.hSpace,

                // Salary chip
                if (job.salaryRangeDisplay != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLightColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.payments_outlined,
                          size: 14,
                          color: AppColors.primaryColor,
                        ),
                        6.wSpace,
                        Text(
                          job.salaryRangeDisplay!,
                          style: AppTextStyles.semibold14.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  12.hSpace,
                ],

                // Skill chips (horizontally scrollable, capped)
                if (job.keySkills != null && job.keySkills!.isNotEmpty)
                  SizedBox(
                    height: 26,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: job.keySkills!.take(6).length,
                      separatorBuilder: (_, __) => 6.wSpace,
                      itemBuilder: (context, index) {
                        final skill = job.keySkills![index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Center(
                            child: Text(
                              skill,
                              style: AppTextStyles.regular12.copyWith(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                10.hSpace,
                Divider(height: 1, color: Colors.grey.shade100),
                8.hSpace,

                // Footer: posted time + employment type
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _timeAgo(job.datePosted),
                      style: AppTextStyles.regular12.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    if (job.employmentType != null &&
                        job.employmentType!.isNotEmpty)
                      Text(
                        job.employmentType!.first.replaceAll('_', ' '),
                        style: AppTextStyles.medium14.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _timeAgo(DateTime? date) {
    if (date == null) return '';
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _CompanyLogo extends StatelessWidget {
  final String? logoUrl;
  final String name;

  const _CompanyLogo({this.logoUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    if (logoUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          logoUrl!,
          width: 44,
          height: 44,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _fallback(),
        ),
      );
    }
    return _fallback();
  }

  Widget _fallback() {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}

class _WorkArrangementBadge extends StatelessWidget {
  final String type;

  const _WorkArrangementBadge({required this.type});

  Color get _color {
    final lower = type.toLowerCase();
    if (lower.contains('remote')) return Colors.green;
    if (lower.contains('hybrid')) return Colors.orange;
    return Colors.blueGrey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        type,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: _color,
        ),
      ),
    );
  }
}
