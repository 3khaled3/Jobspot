import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jobs_fantastic/app/home/data/model/job_search_params.dart';
import 'package:jobs_fantastic/app/home/model_view/all_jobs_cubit/all_jobs_cubit.dart';
import 'package:jobs_fantastic/app/home/view/widget/job_card.dart';
import 'package:jobs_fantastic/app/job_details/view/job_details_view.dart';
import 'package:jobs_fantastic/core/const/app_colors.dart';
import 'package:jobs_fantastic/core/extension/sized_box_extension.dart';

import 'home_error_widget.dart';
import 'home_header.dart';
import 'widget/filter_buttom_sheet.dart';
import 'widget/job_search_bar.dart';
import 'widget/quick_filter_chips.dart';

/// =====================================================
/// HOME VIEW
/// =====================================================
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final _scrollController = ScrollController();
  late final AllJobsCubit _cubit;

  String _query = '';
  String _location = 'United States';
  String _timeFrame = '24h';
  String? _arrangement;
  String _employmentType = 'Any';
  bool _visaSponsorship = false;

  int get _activeFilterCount {
    int count = 0;
    if (_arrangement != null) count++;
    if (_employmentType != 'Any') count++;
    if (_visaSponsorship) count++;
    return count;
  }

  @override
  void initState() {
    super.initState();
    _cubit = AllJobsCubit()..getAllJobs(params: _buildParams());
    // _scrollController.addListener(_onScroll);
  }

  // void _onScroll() {
  //   if (_scrollController.position.pixels >=
  //       _scrollController.position.maxScrollExtent - 300) {
  //     // Assumes AllJobsCubit exposes loadMore() to fetch and append the next page.
  //     // _cubit.loadMore();
  //   }
  // }

  JobSearchParams _buildParams() {
    return JobSearchParams(
      title: _query.isEmpty ? 'data scientist' : _query,
      location: _location,
      timeFrame: _timeFrame,
      limit: 10,
      offset: 0,
      descriptionFormat: 'text',
      remote: _arrangement == 'Remote' ? true : null,
      employmentType: _employmentType == 'Any'
          ? null
          : _employmentType.toUpperCase().replaceAll(' ', '_'),
    );
  }

  void _refetch() => _cubit.getAllJobs(params: _buildParams());

  @override
  void dispose() {
    // _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: BlocProvider.value(
          value: _cubit,
          child: Column(
            children: [
              /// --------------------------------------------
              /// Header
              /// --------------------------------------------
              HomeHeader(),
              14.hSpace,

              /// --------------------------------------------
              /// Search bar
              /// --------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: JobSearchBar(
                  activeFilterCount: _activeFilterCount,
                  onChanged: (value) {
                    setState(() => _query = value);
                    _refetch();
                  },
                  onFilterTap: () async {
                    final result = await showFilterBottomSheet(
                      context,
                      initialLocation: _location,
                      initialEmploymentType: _employmentType,
                      initialVisaSponsorship: _visaSponsorship,
                    );
                    if (result != null) {
                      setState(() {
                        _location = result.location;
                        _employmentType = result.employmentType;
                        _visaSponsorship = result.visaSponsorship;
                      });
                      _refetch();
                    }
                  },
                ),
              ),
              14.hSpace,

              /// --------------------------------------------
              /// Quick Filters
              ///----------------------------------------------
              QuickFilterChips(
                selectedTimeFrame: _timeFrame,
                selectedArrangement: _arrangement,
                onTimeFrameChanged: (value) {
                  setState(() => _timeFrame = value);
                  _refetch();
                },
                onArrangementChanged: (value) {
                  setState(() => _arrangement = value);
                  _refetch();
                },
              ),
              10.hSpace,

              /// --------------------------------------------
              /// Job list
              /// --------------------------------------------
              Expanded(
                child: BlocBuilder<AllJobsCubit, AllJobsState>(
                  builder: (context, state) {
                    if (state is AllJobsLoading) {
                      return const JobListSkeleton();
                    }

                    if (state is AllJobsError) {
                      return HomeErrorWidget(
                        message: state.message,
                        onRetry: _refetch,
                      );
                    }

                    if (state is AllJobsSuccess) {
                      final jobs = state.jobs;
                      if (jobs.isEmpty) return const EmptyState();

                      return RefreshIndicator(
                        color: AppColors.primaryColor,
                        onRefresh: () async => _refetch(),
                        child: ListView.builder(
                          // controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 4, bottom: 16),
                          itemCount: jobs.length + 1,
                          itemBuilder: (context, index) {
                            if (index == jobs.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.4,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return JobCard(
                              job: jobs[index],
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      JobDetailsView(job: jobs[index]),
                                ),
                              ),
                              onSave: () {},
                            );
                          },
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
