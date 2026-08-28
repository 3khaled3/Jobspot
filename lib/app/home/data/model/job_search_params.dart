class JobSearchParams {
  final String title;
  final String location;
  final String timeFrame;
  final int limit;
  final int offset;
  final String descriptionFormat;
  final String? organization;
  final bool? remote;
  final String? employmentType;

  const JobSearchParams({
    required this.title,
    required this.location,
    this.timeFrame = '24h',
    this.limit = 10,
    this.offset = 0,
    this.descriptionFormat = 'text',
    this.organization,
    this.remote,
    this.employmentType,
  });

  Map<String, dynamic> toQueryParameters() {
    return {
      'title': title,
      'location': location,
      'time_frame': timeFrame,
      'limit': limit,
      'offset': offset,
      'description_format': descriptionFormat,
      if (organization != null) 'organization': organization,
      if (remote != null) 'remote': remote,
      if (employmentType != null) 'employment_type': employmentType,
    };
  }

  JobSearchParams copyWith({
    String? title,
    String? location,
    String? timeFrame,
    int? limit,
    int? offset,
    String? descriptionFormat,
    String? organization,
    bool? remote,
    String? employmentType,
  }) {
    return JobSearchParams(
      title: title ?? this.title,
      location: location ?? this.location,
      timeFrame: timeFrame ?? this.timeFrame,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      descriptionFormat: descriptionFormat ?? this.descriptionFormat,
      organization: organization ?? this.organization,
      remote: remote ?? this.remote,
      employmentType: employmentType ?? this.employmentType,
    );
  }
}
