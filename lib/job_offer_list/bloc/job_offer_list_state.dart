part of 'job_offer_list_bloc.dart';

@immutable
abstract class JobOfferListState extends Equatable {
  const JobOfferListState(
    this.jobOfferList,
    this.nextCursor,
    this.hasMore,
  );

  final List<JobOffer> jobOfferList;
  final String? nextCursor;
  final bool hasMore;

  @override
  List<Object?> get props => [jobOfferList, nextCursor, hasMore];
}

class JobOfferListInitial extends JobOfferListState {
  const JobOfferListInitial(List<JobOffer> jobOfferList)
      : super(jobOfferList, null, false);
}

class JobOfferListFilled extends JobOfferListState {
  const JobOfferListFilled(super.jobOfferList, super.nextCursor, super.hasMore);
}
