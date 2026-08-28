import 'package:flutter/material.dart';
import 'package:jobs_fantastic/core/const/app_colors.dart';
import 'package:jobs_fantastic/core/const/app_text_styles.dart';
import 'package:jobs_fantastic/core/extension/sized_box_extension.dart';

/// =====================================================
/// FILTER BOTTOM SHEET
/// =====================================================
class FilterResult {
  final String location;
  final String employmentType;
  final bool visaSponsorship;

  FilterResult({
    required this.location,
    required this.employmentType,
    required this.visaSponsorship,
  });
}

Future<FilterResult?> showFilterBottomSheet(
  BuildContext context, {
  required String initialLocation,
  String initialEmploymentType = 'Any',
  bool initialVisaSponsorship = false,
}) {
  return showModalBottomSheet<FilterResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _FilterSheet(
      initialLocation: initialLocation,
      initialEmploymentType: initialEmploymentType,
      initialVisaSponsorship: initialVisaSponsorship,
    ),
  );
}

/// --------------------------------------------
/// Filter Bottom Sheet
/// --------------------------------------------
class _FilterSheet extends StatefulWidget {
  final String initialLocation;
  final String initialEmploymentType;
  final bool initialVisaSponsorship;

  const _FilterSheet({
    required this.initialLocation,
    required this.initialEmploymentType,
    required this.initialVisaSponsorship,
  });

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late String _location = widget.initialLocation;
  late String _employmentType = widget.initialEmploymentType;
  late bool _visaSponsorship = widget.initialVisaSponsorship;

  static const _employmentTypes = [
    'Any',
    'Full time',
    'Part time',
    'Contract',
    'Internship',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              20.hSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Filters', style: AppTextStyles.bold20),
                  TextButton(
                    onPressed: () => setState(() {
                      _location = 'United States';
                      _employmentType = 'Any';
                      _visaSponsorship = false;
                    }),
                    child: Text(
                      'Reset',
                      style: AppTextStyles.medium14.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              20.hSpace,
              Text('Location', style: AppTextStyles.semibold14),
              10.hSpace,
              TextFormField(
                initialValue: _location,
                onChanged: (v) => _location = v,
                decoration: InputDecoration(
                  hintText: 'e.g. United States, Remote',
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
              ),
              20.hSpace,
              Text('Employment type', style: AppTextStyles.semibold14),
              10.hSpace,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _employmentTypes.map((type) {
                  final selected = _employmentType == type;
                  return ChoiceChip(
                    label: Text(type),
                    selected: selected,
                    onSelected: (_) => setState(() => _employmentType = type),
                    selectedColor: AppColors.primaryColor,
                    backgroundColor: AppColors.backgroundColor,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.grey.shade700,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide.none,
                    ),
                    showCheckmark: false,
                  );
                }).toList(),
              ),
              12.hSpace,
              SwitchListTile(
                value: _visaSponsorship,
                onChanged: (v) => setState(() => _visaSponsorship = v),
                title: Text(
                  'Visa sponsorship only',
                  style: AppTextStyles.regular14,
                ),
                activeColor: AppColors.primaryColor,
                contentPadding: EdgeInsets.zero,
              ),
              20.hSpace,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      FilterResult(
                        location: _location,
                        employmentType: _employmentType,
                        visaSponsorship: _visaSponsorship,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Apply filters',
                    style: AppTextStyles.medium14.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
