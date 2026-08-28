import 'package:flutter/material.dart';
import 'package:jobs_fantastic/app/home/data/model/job_model.dart';
import 'package:jobs_fantastic/core/extension/sized_box_extension.dart';

class JobInformation extends StatelessWidget {
  const JobInformation({required this.job});

  final JobListing job;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Job Information',
      icon: Icons.info_outline_rounded,
      child: Column(
        children: [
          _DetailRow(
            title: 'Experience',
            value: job.experienceLevel ?? 'Not specified',
          ),
          _DetailRow(
            title: 'Employment',
            value: job.employmentType?.join(', ') ?? 'Not specified',
          ),
          _DetailRow(
            title: 'Working hours',
            value: job.workingHours != null
                ? '${job.workingHours} hours/day'
                : 'Not specified',
          ),
          _DetailRow(
            title: 'Visa sponsorship',
            value: job.visaSponsorship == true ? 'Available' : 'Not available',
          ),
          _DetailRow(
            title: 'Office days',
            value: job.workArrangementOfficeDays != null
                ? '${job.workArrangementOfficeDays} days/week'
                : 'Not specified',
          ),
          if (job.education?.isNotEmpty ?? false)
            _DetailRow(title: 'Education', value: job.education!.join(', ')),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              title,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF635BFF).withOpacity(.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: const Color(0xFF635BFF), size: 20),
              ),
              11.wSpace,
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          16.hSpace,
          child,
        ],
      ),
    );
  }
}
