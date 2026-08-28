import 'package:flutter/material.dart';
import 'package:jobs_fantastic/app/home/data/model/job_model.dart';
import 'package:jobs_fantastic/core/extension/sized_box_extension.dart';

class QuickInfo extends StatelessWidget {
  const QuickInfo({super.key, required this.job});

  final JobListing job;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickInfoItem(
            icon: Icons.work_outline_rounded,
            title: 'Work Type',
            value: job.workArrangement ?? 'Not specified',
          ),
        ),
        10.wSpace,
        Expanded(
          child: _QuickInfoItem(
            icon: Icons.payments_outlined,
            title: 'Salary',
            value: job.salaryRangeDisplay ?? 'Not specified',
          ),
        ),
      ],
    );
  }
}

class _QuickInfoItem extends StatelessWidget {
  const _QuickInfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF635BFF), size: 22),
          10.hSpace,
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
          3.hSpace,
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
