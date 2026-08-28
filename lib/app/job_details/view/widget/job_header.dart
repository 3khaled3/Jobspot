import 'package:flutter/material.dart';
import 'package:jobs_fantastic/app/home/data/model/job_model.dart';
import 'package:jobs_fantastic/core/extension/sized_box_extension.dart';

class JobHeader extends StatelessWidget {
  const JobHeader({super.key, required this.job});

  final JobListing job;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 90, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF635BFF), Color(0xFF4338CA)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              _CompanyLogo(imageUrl: job.organizationLogo),
              14.wSpace,
              Expanded(
                child: Text(
                  job.organization,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          18.hSpace,

          Text(
            job.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              height: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),

          12.hSpace,

          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.white70,
                size: 18,
              ),
              5.wSpace,
              Expanded(
                child: Text(
                  _locationText(job),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _locationText(JobListing job) {
    if (job.locations.isNotEmpty) {
      return job.locations.first.toString();
    }

    if (job.locationsAlt?.isNotEmpty ?? false) {
      return job.locationsAlt!.first;
    }

    if (job.locationsDerived?.isNotEmpty ?? false) {
      return job.locationsDerived!.first;
    }

    return 'Location not specified';
  }
}

class _CompanyLogo extends StatelessWidget {
  const _CompanyLogo({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: imageUrl == null || imageUrl!.isEmpty
          ? const Icon(
              Icons.business_rounded,
              color: Color(0xFF635BFF),
              size: 30,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.network(
                imageUrl!,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.business_rounded,
                    color: Color(0xFF635BFF),
                  );
                },
              ),
            ),
    );
  }
}
