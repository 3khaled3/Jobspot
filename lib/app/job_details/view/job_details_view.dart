import 'package:flutter/material.dart';
import 'package:jobs_fantastic/app/home/data/model/job_model.dart';
import 'package:jobs_fantastic/app/job_details/view/widget/apply_button.dart';
import 'package:jobs_fantastic/app/job_details/view/widget/bullet_text.dart';
import 'package:jobs_fantastic/app/job_details/view/widget/info_row.dart';
import 'package:jobs_fantastic/app/job_details/view/widget/job_header.dart';
import 'package:jobs_fantastic/app/job_details/view/widget/job_information.dart';
import 'package:jobs_fantastic/app/job_details/view/widget/quick_info.dart';
import 'package:jobs_fantastic/app/job_details/view/widget/skill_chip.dart';
import 'package:jobs_fantastic/core/extension/sized_box_extension.dart';

class JobDetailsView extends StatelessWidget {
  const JobDetailsView({super.key, required this.job});

  final JobListing job;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 280,
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(background: JobHeader(job: job)),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 110),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                QuickInfo(job: job),

                20.hSpace,

                if (job.descriptionText.isNotEmpty)
                  SectionCard(
                    title: 'About this job',
                    icon: Icons.description_outlined,
                    child: Text(
                      job.descriptionText,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),

                if (job.keySkills?.isNotEmpty ?? false) ...[
                  16.hSpace,
                  SectionCard(
                    title: 'Skills',
                    icon: Icons.code_rounded,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: job.keySkills!
                          .map((skill) => SkillChip(label: skill))
                          .toList(),
                    ),
                  ),
                ],

                if (job.coreResponsibilities?.isNotEmpty ?? false) ...[
                  16.hSpace,
                  SectionCard(
                    title: 'Responsibilities',
                    icon: Icons.task_alt_rounded,
                    child: BulletText(text: job.coreResponsibilities!),
                  ),
                ],

                if (job.requirementsSummary?.isNotEmpty ?? false) ...[
                  16.hSpace,
                  SectionCard(
                    title: 'Requirements',
                    icon: Icons.checklist_rounded,
                    child: BulletText(text: job.requirementsSummary!),
                  ),
                ],

                if (job.benefits?.isNotEmpty ?? false) ...[
                  16.hSpace,
                  SectionCard(
                    title: 'Benefits',
                    icon: Icons.card_giftcard_rounded,
                    child: Column(
                      children: job.benefits!
                          .map(
                            (benefit) => InfoRow(
                              icon: Icons.check_circle_outline_rounded,
                              text: benefit,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],

                16.hSpace,

                JobInformation(job: job),
              ]),
            ),
          ),
        ],
      ),

      bottomSheet: ApplyButton(
        onPressed: () {
          // TODO: Open job.url
        },
      ),
    );
  }
}
