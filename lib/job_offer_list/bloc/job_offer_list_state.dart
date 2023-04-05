part of 'job_offer_list_bloc.dart';

@immutable
abstract class JobOfferListState extends Equatable {
  const JobOfferListState(this.jobOfferList);
  final List<JobOffer> jobOfferList;

  @override
  List<Object> get props => [jobOfferList];
}

class JobOfferListInitial extends JobOfferListState {
  const JobOfferListInitial(super.jobOfferList);
}

class JobOfferListFilled extends JobOfferListState {
  const JobOfferListFilled(super.jobOfferList);
}
