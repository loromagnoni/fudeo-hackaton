part of 'job_offer_list_bloc.dart';

@immutable
abstract class JobOfferListEvent extends Equatable {
  const JobOfferListEvent();

  @override
  List<Object> get props => [];
}

class JobOfferListChange extends JobOfferListEvent {
  const JobOfferListChange(this.jobOfferList);

  final List<JobOffer> jobOfferList;

  @override
  List<Object> get props => [jobOfferList];
}
