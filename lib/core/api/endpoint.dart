import 'package:jobs_fantastic/app/home/data/model/job_search_params.dart';

class EndPoints {
  static const String baseUrl = 'https://active-jobs-db.p.rapidapi.com';

  static const String activeAts = '$baseUrl/active-ats';

  static String buildActiveJobsUrl({required JobSearchParams params}) {
    const host = 'active-jobs-db.p.rapidapi.com';
    const path = '/active-ats';

    final queryParams = <String, String>{
      'title': '"${params.title}"',
      'location': params.location,
      'time_frame': params.timeFrame,
      'limit': params.limit.toString(),
      'offset': params.offset.toString(),
      'description_format': params.descriptionFormat,
      if (params.organization != null)
        'organization': '"${params.organization}"',
      if (params.remote != null) 'remote': params.remote.toString(),
      if (params.employmentType != null)
        'employment_type': params.employmentType.toString(),
    };

    return Uri.https(host, path, queryParams).toString();
  }

  static const String activeAtsCount = '$baseUrl/active-ats-count';

  static const String expiredAts = '$baseUrl/expired-ats';

  static const String atsOrganizations = '$baseUrl/ats-organizations';
}
