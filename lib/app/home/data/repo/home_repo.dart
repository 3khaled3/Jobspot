import 'package:dartz/dartz.dart';
import 'package:jobs_fantastic/app/home/data/model/job_search_params.dart';
import 'package:jobs_fantastic/core/api/endpoint.dart';
import 'package:jobs_fantastic/core/api/http_helper.dart';

class HomeRepo {
  Future<Either<FailureModel, Map<String, dynamic>>> getJobs({
    required JobSearchParams params,
  }) {
    final response = HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: EndPoints.buildActiveJobsUrl(params: params),
        token: token!,
      ),
    );

    return response;
  }
}
