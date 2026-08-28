import 'job_location_model.dart';

class JobListing {
  final int id;
  final DateTime? datePosted;
  final DateTime? dateCreated;
  final String title;
  final String organization;
  final String? organizationUrl;
  final String? organizationLogo;
  final DateTime? dateValidThrough;
  final List<JobLocation> locations;
  final List<String>? locationsAlt;
  final String? locationType;
  final String url;
  final String source;
  final String sourceDomain;

  final List<String>? citiesDerived;
  final List<String>? regionsDerived;
  final List<String>? countriesDerived;
  final List<String>? locationsDerived;

  final String? salaryCurrency;
  final int? salaryMinValue;
  final int? salaryMaxValue;
  final String? salaryUnitText;

  final List<String>? benefits;
  final String? experienceLevel; // e.g. "5-10"
  final String? workArrangement; // e.g. "Hybrid", "Remote OK"
  final int? workArrangementOfficeDays;

  final List<String>? keySkills;
  final String? coreResponsibilities;
  final String? requirementsSummary;
  final int? workingHours;
  final List<String>? employmentType;
  final bool? visaSponsorship;
  final List<String>? keywords;
  final List<String>? taxonomies;
  final List<String>? education;

  final String descriptionText;

  JobListing({
    required this.id,
    this.datePosted,
    this.dateCreated,
    required this.title,
    required this.organization,
    this.organizationUrl,
    this.organizationLogo,
    this.dateValidThrough,
    this.locations = const [],
    this.locationsAlt,
    this.locationType,
    required this.url,
    required this.source,
    required this.sourceDomain,
    this.citiesDerived,
    this.regionsDerived,
    this.countriesDerived,
    this.locationsDerived,
    this.salaryCurrency,
    this.salaryMinValue,
    this.salaryMaxValue,
    this.salaryUnitText,
    this.benefits,
    this.experienceLevel,
    this.workArrangement,
    this.workArrangementOfficeDays,
    this.keySkills,
    this.coreResponsibilities,
    this.requirementsSummary,
    this.workingHours,
    this.employmentType,
    this.visaSponsorship,
    this.keywords,
    this.taxonomies,
    this.education,
    required this.descriptionText,
  });

  factory JobListing.fromJson(Map<String, dynamic> json) {
    return JobListing(
      id: json['id'],
      datePosted: _parseDate(json['date_posted']),
      dateCreated: _parseDate(json['date_created']),
      title: json['title'] ?? '',
      organization: json['organization'] ?? '',
      organizationUrl: json['organization_url'],
      organizationLogo: json['organization_logo'],
      dateValidThrough: _parseDate(json['date_valid_through']),
      locations: (json['locations_raw'] as List<dynamic>? ?? [])
          .map((l) => JobLocation.fromJson(l))
          .toList(),
      locationsAlt: _stringList(json['locations_alt']),
      locationType: json['location_type'],
      url: json['url'] ?? '',
      source: json['source'] ?? '',
      sourceDomain: json['source_domain'] ?? '',
      citiesDerived: _stringList(json['cities_derived']),
      regionsDerived: _stringList(json['regions_derived']),
      countriesDerived: _stringList(json['countries_derived']),
      locationsDerived: _stringList(json['locations_derived']),
      salaryCurrency: json['ai_salary_currency'],
      salaryMinValue: json['ai_salary_min_value'],
      salaryMaxValue: json['ai_salary_max_value'],
      salaryUnitText: json['ai_salary_unit_text'],
      benefits: _stringList(json['ai_benefits']),
      experienceLevel: json['ai_experience_level'],
      workArrangement: json['ai_work_arrangement'],
      workArrangementOfficeDays: json['ai_work_arrangement_office_days'],
      keySkills: _stringList(json['ai_key_skills']),
      coreResponsibilities: json['ai_core_responsibilities'],
      requirementsSummary: json['ai_requirements_summary'],
      workingHours: json['ai_working_hours'],
      employmentType: _stringList(json['ai_employment_type']),
      visaSponsorship: json['ai_visa_sponsorship'],
      keywords: _stringList(json['ai_keywords']),
      taxonomies: _stringList(json['ai_taxonomies_a']),
      education: _stringList(json['ai_education']),
      descriptionText: json['description_text'] ?? '',
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  static List<String>? _stringList(dynamic value) {
    if (value == null) return null;
    return List<String>.from(value);
  }

  /// Convenience getter for a display-ready salary range
  String? get salaryRangeDisplay {
    if (salaryMinValue == null || salaryMaxValue == null) return null;
    final currency = salaryCurrency ?? '';
    final unit = salaryUnitText?.toLowerCase() ?? '';
    return '$currency${_formatNumber(salaryMinValue!)} - $currency${_formatNumber(salaryMaxValue!)}/$unit';
  }

  static String _formatNumber(int n) {
    return n.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }
}
