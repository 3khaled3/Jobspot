part of 'all_jobs_cubit.dart';

sealed class AllJobsState {}

final class AllJobsInitial extends AllJobsState {}

final class AllJobsLoading extends AllJobsState {}

final class AllJobsSuccess extends AllJobsState {
  final List<JobListing> jobs;

  AllJobsSuccess({required this.jobs});
}

final class AllJobsError extends AllJobsState {
  final String message;

  AllJobsError({required this.message});
}
