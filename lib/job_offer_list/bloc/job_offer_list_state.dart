part of 'job_offer_list_bloc.dart';

enum OpportunityType { jobOffer, freelanceProject }

@immutable
abstract class JobOfferListState extends Equatable {
  const JobOfferListState(
    this.jobOfferList,
    this.freelanceList,
    this.selectedType,
  );
  final List<JobOffer> jobOfferList;
  final List<Freelance> freelanceList;
  final OpportunityType selectedType;

  List<Opportunity> get filteredOpportunities {
    return selectedType == OpportunityType.jobOffer
        ? jobOfferList.map(Opportunity.fromJobOffer).toList()
        : freelanceList.map(Opportunity.fromFreelance).toList();
  }

  @override
  List<Object> get props => [jobOfferList, freelanceList, selectedType];
}

class JobOfferListInitial extends JobOfferListState {
  const JobOfferListInitial(
    super.jobOfferList,
    super.freelanceList,
    super.selectedType,
  );
}

class JobOfferListFilled extends JobOfferListState {
  const JobOfferListFilled(
    super.jobOfferList,
    super.freelanceList,
    super.selectedType,
  );
}
