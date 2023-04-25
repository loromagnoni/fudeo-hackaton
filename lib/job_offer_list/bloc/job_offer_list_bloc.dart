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
        super(const JobOfferListInitial([], [], OpportunityType.jobOffer)) {
    on<JobOfferListChange>(_handleJobOfferListChange);
    on<FreelanceListChange>(_handleFreelanceListChange);
    on<JobOfferListTap>(_handleJobOfferListTap);
    on<OpportunityToggleTap>(_handleOpportunityToggleTap);
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
}
