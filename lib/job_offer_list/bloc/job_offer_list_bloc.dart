import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/home/bloc/home_bloc.dart';
import 'package:job_offer_repository/job_offer_repository.dart';

part 'job_offer_list_event.dart';
part 'job_offer_list_state.dart';

typedef OpenJobOfferCallback = void Function(JobOffer jobOffer);

class JobOfferListBloc extends Bloc<JobOfferListEvent, JobOfferListState> {
  JobOfferListBloc({
    required JobOfferRepository jobOfferRepository,
    required OpenJobOfferCallback openJobOfferDetailPage,
  })  : _jobOfferRepository = jobOfferRepository,
        _openJobOfferDetailPageCallback = openJobOfferDetailPage,
        super(
          const JobOfferListInitial(
            [],
            [],
            OpportunityType.jobOffer,
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
    _jobOfferListSubscription = _jobOfferRepository.jobOfferList.listen((list) {
      add(JobOfferListChange(list));
    });
    _freelanceListSubscription =
        _jobOfferRepository.freelanceList.listen((list) {
      add(FreelanceListChange(list));
    });
    _jobOfferRepository.loadJobOffers();
  }

  final JobOfferRepository _jobOfferRepository;
  late StreamSubscription<List<JobOffer>> _jobOfferListSubscription;
  late StreamSubscription<List<Freelance>> _freelanceListSubscription;
  final OpenJobOfferCallback _openJobOfferDetailPageCallback;

  void _handleFreelanceListChange(
    FreelanceListChange event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(
      JobOfferListFilled(
        state.jobOfferList,
        event.freelanceList,
        state.selectedType,
        state.filter,
      ),
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
      ),
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

  void _handleOpportunityFilterTap(
    OpportunityFilterTap event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(
      state is JobOfferListFilled
          ? OpportunityFilterEditing(
              state.jobOfferList,
              state.freelanceList,
              state.selectedType,
              state.filter,
              filterToApply: state.filter,
            )
          : state is OpportunityFilterEditing
              ? JobOfferListFilled(
                  state.jobOfferList,
                  state.freelanceList,
                  state.selectedType,
                  state.filter,
                )
              : state,
    );
  }

  void _handleCancelFilterTap(
    CancelFilterTap event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(
      state is OpportunityFilterEditing
          ? JobOfferListFilled(
              state.jobOfferList,
              state.freelanceList,
              state.selectedType,
              state.filter,
            )
          : state,
    );
  }

  void _handleApplyFilterTap(
    ApplyFilterTap event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(
      state is OpportunityFilterEditing
          ? JobOfferListFilled(
              state.jobOfferList,
              state.freelanceList,
              state.selectedType,
              (state as OpportunityFilterEditing).filterToApply,
            )
          : state,
    );
  }

  void _handleFilterTap(
    FilterTap event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(
      state is OpportunityFilterEditing
          ? OpportunityFilterEditing(
              state.jobOfferList,
              state.freelanceList,
              state.selectedType,
              state.filter,
              filterToApply: (state as OpportunityFilterEditing)
                  .filterToApply
                  .toggleFilter(
                    event.filter,
                  ),
            )
          : state,
    );
  }
}
