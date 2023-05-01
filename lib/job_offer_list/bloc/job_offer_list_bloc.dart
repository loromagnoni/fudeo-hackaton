import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/home/bloc/home_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/filter.dart';
import 'package:job_offer_repository/job_offer_repository.dart';

part 'job_offer_list_event.dart';
part 'job_offer_list_state.dart';

typedef OpenJobOfferCallback = void Function(JobOffer jobOffer);
typedef OpenFreelanceCallback = void Function(Freelance freelance);
typedef OpenFilterDialogCallback = Future<void> Function(JobOfferListBloc self);

class JobOfferListBloc extends Bloc<JobOfferListEvent, JobOfferListState> {
  JobOfferListBloc({
    required JobOfferRepository jobOfferRepository,
    required OpenJobOfferCallback openJobOfferDetailPage,
    required OpenFreelanceCallback openFreelanceDetailPage,
    required OpenFilterDialogCallback openFilterDialog,
  })  : _jobOfferRepository = jobOfferRepository,
        _openJobOfferDetailPageCallback = openJobOfferDetailPage,
        _openFreelanceDetailPageCallback = openFreelanceDetailPage,
        _openFilterDialogCallback = openFilterDialog,
        super(
          const JobOfferListInitial(
            [],
            [],
            OpportunityType.jobOffer,
            OpportunityFilter(),
            OpportunityFilter(),
          ),
        ) {
    on<JobOfferListChange>(_handleJobOfferListChange);
    on<FreelanceListChange>(_handleFreelanceListChange);
    on<JobOfferListTap>(_handleJobOfferListTap);
    on<OpportunityToggleTap>(_handleOpportunityToggleTap);
    on<SearchTextChanged>(_handleSearchTextChanged);
    on<OpportunityFilterTap>(_handleOpportunityFilterTap);
    on<FilterTap>(_handleFilterTap);
    on<CancelFilterTap>(_handleCancelFilterTap);
    on<ApplyFilterTap>(_handleApplyFilterTap);
    on<FilterChipTap>(_handleFilterChipTap);
    on<EmptyFilterTap>(_handleEmptyFilterTap);
    on<OpportunityTap>(_handleOpportunityTap);
    _jobOfferListSubscription = _jobOfferRepository.jobOfferList.listen((list) {
      add(JobOfferListChange(list));
    });
    _freelanceListSubscription =
        _jobOfferRepository.freelanceList.listen((list) {
      add(FreelanceListChange(list));
    });
    _jobOfferRepository
      ..loadJobOffers()
      ..loadFreelanceProjects();
  }

  final JobOfferRepository _jobOfferRepository;
  late StreamSubscription<List<JobOffer>> _jobOfferListSubscription;
  late StreamSubscription<List<Freelance>> _freelanceListSubscription;
  final OpenJobOfferCallback _openJobOfferDetailPageCallback;
  final OpenFreelanceCallback _openFreelanceDetailPageCallback;
  final OpenFilterDialogCallback _openFilterDialogCallback;

  void _handleFreelanceListChange(
    FreelanceListChange event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(
      JobOfferListFilled(state.jobOfferList, event.freelanceList,
          state.selectedType, state.filter, state.filterToApply),
    );
  }

  void _handleJobOfferListChange(
    JobOfferListChange event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(JobOfferListFilled(
      event.jobOfferList,
      state.freelanceList,
      state.selectedType,
      state.filter,
      state.filterToApply,
    ));
  }

  void _handleOpportunityToggleTap(
    OpportunityToggleTap event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(
      JobOfferListFilled(
        state.jobOfferList,
        state.freelanceList,
        state.selectedType == OpportunityType.jobOffer
            ? OpportunityType.freelanceProject
            : OpportunityType.jobOffer,
        state.filter,
        state.filterToApply,
      ),
    );
  }

  void _handleSearchTextChanged(
    SearchTextChanged event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(
      JobOfferListFilled(
          state.jobOfferList,
          state.freelanceList,
          state.selectedType,
          state.filter.copyWith(title: event.searchText),
          state.filterToApply),
    );
  }

  @override
  Future<void> close() {
    _jobOfferListSubscription.cancel();
    return super.close();
  }

  void _handleJobOfferListTap(
    JobOfferListTap event,
    Emitter<JobOfferListState> emit,
  ) {
    _openJobOfferDetailPageCallback(event.jobOffer);
  }

  Future<void> _handleOpportunityFilterTap(
    OpportunityFilterTap event,
    Emitter<JobOfferListState> emit,
  ) async {
    emit(JobOfferListFilled(state.jobOfferList, state.freelanceList,
        state.selectedType, state.filter, state.filterToApply));
    await _openFilterDialogCallback(
      this,
    );
  }

  void _handleCancelFilterTap(
    CancelFilterTap event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(JobOfferListFilled(
      state.jobOfferList,
      state.freelanceList,
      state.selectedType,
      state.filter,
      const OpportunityFilter(),
    ));
  }

  void _handleApplyFilterTap(
    ApplyFilterTap event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(JobOfferListFilled(
      state.jobOfferList,
      state.freelanceList,
      state.selectedType,
      state.filterToApply,
      state.filterToApply,
    ));
  }

  void _handleFilterTap(
    FilterTap event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(
      JobOfferListFilled(
        state.jobOfferList,
        state.freelanceList,
        state.selectedType,
        state.filter,
        state.filterToApply.toggleFilter(
          event.filter,
        ),
      ),
    );
  }

  void _handleFilterChipTap(
    FilterChipTap event,
    Emitter<JobOfferListState> emit,
  ) {
    final newFilter = state.filter.copyWith(
        filters: state.filter.filters.where((f) => f != event.filter).toList());
    emit(
      JobOfferListFilled(
        state.jobOfferList,
        state.freelanceList,
        state.selectedType,
        newFilter,
        newFilter,
      ),
    );
  }

  void _handleEmptyFilterTap(
    EmptyFilterTap event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(
      JobOfferListFilled(
        state.jobOfferList,
        state.freelanceList,
        state.selectedType,
        const OpportunityFilter(),
        const OpportunityFilter(),
      ),
    );
  }

  void _handleOpportunityTap(
      OpportunityTap event, Emitter<JobOfferListState> emit) {
    final id = event.opportunity.id;
    final isJobOffer = state.jobOfferList.any((j) => j.id == id);
    if (isJobOffer) {
      _openJobOfferDetailPageCallback(
          state.jobOfferList.firstWhere((j) => j.id == id));
    } else {
      _openFreelanceDetailPageCallback(
          state.freelanceList.firstWhere((f) => f.id == id));
    }
  }
}
