import 'package:bloc/bloc.dart';
import 'package:jobs_fantastic/app/home/data/model/job_model.dart';
import 'package:jobs_fantastic/app/home/data/model/job_search_params.dart';
import 'package:jobs_fantastic/app/home/data/repo/home_repo.dart';

part 'all_jobs_state.dart';

class AllJobsCubit extends Cubit<AllJobsState> {
  AllJobsCubit() : super(AllJobsInitial());
  Future<void> getAllJobs({required JobSearchParams params}) async {
    emit(AllJobsLoading());
    final response = await HomeRepo().getJobs(params: params);
    response.fold(
      (failure) {
        emit(AllJobsError(message: failure.message ?? "Something went wrong"));
      },
      (data) {
        final jobs = (data['data'] as List)
            .map((e) => JobListing.fromJson(e))
            .toList();
        emit(AllJobsSuccess(jobs: jobs));
      },
    );
  }
}
