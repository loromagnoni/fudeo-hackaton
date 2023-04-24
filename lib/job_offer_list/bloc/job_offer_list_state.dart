part of 'job_offer_list_bloc.dart';

enum OpportunityType { jobOffer, freelanceProject }

@immutable
abstract class JobOfferListState extends Equatable {
  const JobOfferListState(this.jobOfferList, this.selectedType);
  final List<JobOffer> jobOfferList;
  final OpportunityType selectedType;

  List<Opportunity> get filteredOpportunities {
    return selectedType == OpportunityType.jobOffer
        ? jobOfferList.map(Opportunity.fromJobOffer).toList()
        : [];
  }

  @override
  List<Object> get props => [jobOfferList, selectedType];
}

class JobOfferListInitial extends JobOfferListState {
  const JobOfferListInitial(super.jobOfferList, super.selectedType);
}

class JobOfferListFilled extends JobOfferListState {
  const JobOfferListFilled(super.jobOfferList, super.selectedType);
}
