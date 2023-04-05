import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:job_offer_repository/job_offer_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'job_offer_list_event.dart';
part 'job_offer_list_state.dart';

class JobOfferListBloc extends Bloc<JobOfferListEvent, JobOfferListState> {
  JobOfferListBloc({required JobOfferRepository jobOfferRepository})
      : _jobOfferRepository = jobOfferRepository,
        super(const JobOfferListInitial([])) {
    on<JobOfferListChange>(_handleJobOfferListChange);
    _jobOfferListSubscription = _jobOfferRepository.jobOfferList
        .interval(const Duration(seconds: 2))
        .listen((list) {
      add(JobOfferListChange(list));
    });
    _jobOfferRepository.loadJobOffers();
  }

  final JobOfferRepository _jobOfferRepository;
  late StreamSubscription<List<JobOffer>> _jobOfferListSubscription;

  void _handleJobOfferListChange(
    JobOfferListChange event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(JobOfferListFilled(event.jobOfferList));
  }

  @override
  Future<void> close() {
    _jobOfferListSubscription.cancel();
    return super.close();
  }
}
