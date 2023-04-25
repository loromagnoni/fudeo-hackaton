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

class FreelanceListChange extends JobOfferListEvent {
  const FreelanceListChange(this.freelanceList);

  final List<Freelance> freelanceList;

  @override
  List<Object> get props => [freelanceList];
}

class JobOfferListTap extends JobOfferListEvent {
  const JobOfferListTap(this.jobOffer);

  final JobOffer jobOffer;

  @override
  List<Object> get props => [jobOffer];
}

class OpportunityToggleTap extends JobOfferListEvent {}
