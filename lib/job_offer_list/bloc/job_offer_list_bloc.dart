import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:job_offer_repository/job_offer_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'job_offer_list_event.dart';
part 'job_offer_list_state.dart';

typedef OpenJobOfferCallback = void Function(JobOffer jobOffer);

class JobOfferListBloc extends Bloc<JobOfferListEvent, JobOfferListState> {
  JobOfferListBloc({
    required JobOfferRepository jobOfferRepository,
    required OpenJobOfferCallback openJobOfferDetailPage,
  })  : _jobOfferRepository = jobOfferRepository,
        _openJobOfferDetailPageCallback = openJobOfferDetailPage,
        super(const JobOfferListInitial([])) {
    on<JobOfferListChange>(_handleJobOfferListChange);
    on<JobOfferListTap>(_handleJobOfferListTap);
    on<JobOfferListLoadMore>(_handleJobOfferListLoadMore);
    _jobOfferListSubscription = _jobOfferRepository.jobOfferList
        .interval(const Duration(seconds: 2))
        .listen((response) {
      add(
        JobOfferListChange(
          response.jobOffers,
          hasMore: response.hasMore,
          nextCursor: response.nextCursor,
        ),
      );
    });
    _jobOfferRepository.loadJobOffers();
  }

  final JobOfferRepository _jobOfferRepository;
  late StreamSubscription<JobOfferListResponse> _jobOfferListSubscription;
  final OpenJobOfferCallback _openJobOfferDetailPageCallback;

  void _handleJobOfferListChange(
    JobOfferListChange event,
    Emitter<JobOfferListState> emit,
  ) {
    emit(
      JobOfferListFilled(
        event.jobOfferList,
        event.nextCursor,
        event.hasMore,
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

  void _handleJobOfferListLoadMore(
    JobOfferListLoadMore event,
    Emitter<JobOfferListState> emit,
  ) {
    if (state.hasMore) {
      _jobOfferRepository.loadJobOffers(cursor: event.nextCursor);
    }
  }
}
