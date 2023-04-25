part of 'job_offer_list_bloc.dart';

enum OpportunityType { jobOffer, freelanceProject }

@immutable
abstract class JobOfferListState extends Equatable {
  const JobOfferListState(
    this.jobOfferList,
    this.freelanceList,
    this.selectedType,
    this.searchText,
  );
  final List<JobOffer> jobOfferList;
  final List<Freelance> freelanceList;
  final OpportunityType selectedType;
  final String? searchText;

  List<Opportunity> get filteredOpportunities {
    final opportunities = selectedType == OpportunityType.jobOffer
        ? jobOfferList.map(Opportunity.fromJobOffer).toList()
        : freelanceList.map(Opportunity.fromFreelance).toList();
    if (searchText == null || searchText!.isEmpty) return opportunities;
    return opportunities
        .where((opportunity) =>
            opportunity.title.toLowerCase().contains(searchText!.toLowerCase()))
        .toList();
  }

  @override
  List<Object?> get props =>
      [jobOfferList, freelanceList, selectedType, searchText];
}

class JobOfferListInitial extends JobOfferListState {
  const JobOfferListInitial(
    super.jobOfferList,
    super.freelanceList,
    super.selectedType,
    super.searchText,
  );
}

class JobOfferListFilled extends JobOfferListState {
  const JobOfferListFilled(super.jobOfferList, super.freelanceList,
      super.selectedType, super.searchText);
}
