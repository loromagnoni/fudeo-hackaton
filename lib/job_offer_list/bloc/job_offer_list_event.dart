part of 'job_offer_list_bloc.dart';

@immutable
abstract class JobOfferListEvent extends Equatable {
  const JobOfferListEvent();

  @override
  List<Object?> get props => [];
}

class JobOfferListChange extends JobOfferListEvent {
  const JobOfferListChange(
    this.jobOfferList, {
    this.nextCursor,
    this.hasMore = false,
  });

  final List<JobOffer> jobOfferList;
  final String? nextCursor;
  final bool hasMore;

  @override
  List<Object?> get props => [jobOfferList, nextCursor, hasMore];
}

class JobOfferListTap extends JobOfferListEvent {
  const JobOfferListTap(this.jobOffer);

  final JobOffer jobOffer;

  @override
  List<Object> get props => [jobOffer];
}

class JobOfferListLoadMore extends JobOfferListEvent {
  const JobOfferListLoadMore(this.nextCursor);

  final String nextCursor;

  @override
  List<Object> get props => [nextCursor];
}
