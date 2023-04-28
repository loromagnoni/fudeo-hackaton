part of 'job_offer_list_bloc.dart';

enum OpportunityType { jobOffer, freelanceProject }

enum Filter {
  fullRemote,
  hybrid,
  onSite,
  fullTime,
  partTime,
  junior,
  mid,
  senior
}

class OpportunityFilter extends Equatable {
  const OpportunityFilter({this.title, this.filters = const []});
  final String? title;
  final List<Filter> filters;

  OpportunityFilter copyWith({String? title, List<Filter>? filters}) {
    return OpportunityFilter(
      title: title ?? this.title,
      filters: filters ?? this.filters,
    );
  }

  OpportunityFilter toggleFilter(Filter filter) {
    return OpportunityFilter(
      title: title,
      filters: filters.contains(filter)
          ? filters.where((f) => f != filter).toList()
          : [...filters, filter],
    );
  }

  @override
  List<Object?> get props => [title, filters];
}

@immutable
abstract class JobOfferListState extends Equatable {
  const JobOfferListState(
    this.jobOfferList,
    this.freelanceList,
    this.selectedType,
    this.filter,
  );
  final List<JobOffer> jobOfferList;
  final List<Freelance> freelanceList;
  final OpportunityType selectedType;
  final OpportunityFilter filter;

  List<Opportunity> get filteredOpportunities {
    final opportunities = selectedType == OpportunityType.jobOffer
        ? jobOfferList
            .where(matchFilter(filter))
            .toList()
            .map(Opportunity.fromJobOffer)
            .toList()
        : freelanceList.map(Opportunity.fromFreelance).toList();
    if (filter.title == null || filter.title!.isEmpty) return opportunities;
    return opportunities.where((opportunity) {
      if (filter.title != null &&
          filter.title!.isNotEmpty &&
          !opportunity.title
              .toLowerCase()
              .contains(filter.title!.toLowerCase())) return false;
      return true;
    }).toList();
  }

  @override
  List<Object?> get props =>
      [jobOfferList, freelanceList, selectedType, filter];
}

class JobOfferListInitial extends JobOfferListState {
  const JobOfferListInitial(
    super.jobOfferList,
    super.freelanceList,
    super.selectedType,
    super.filter,
  );
}

class JobOfferListFilled extends JobOfferListState {
  const JobOfferListFilled(
    super.jobOfferList,
    super.freelanceList,
    super.selectedType,
    super.filter,
  );
}

class OpportunityFilterEditing extends JobOfferListState {
  const OpportunityFilterEditing(
    super.jobOfferList,
    super.freelanceList,
    super.selectedType,
    super.searchText, {
    required this.filterToApply,
  });

  final OpportunityFilter filterToApply;

  @override
  List<Object> get props =>
      [jobOfferList, freelanceList, selectedType, filter, filterToApply];
}
