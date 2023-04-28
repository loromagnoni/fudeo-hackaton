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

class SearchTextChanged extends JobOfferListEvent {
  const SearchTextChanged(this.searchText);

  final String searchText;

  @override
  List<Object> get props => [searchText];
}

class OpportunityFilterTap extends JobOfferListEvent {}

class FilterTap extends JobOfferListEvent {
  const FilterTap(this.filter);

  final Filter filter;

  @override
  List<Object> get props => [filter];
}

class CancelFilterTap extends JobOfferListEvent {}

class ApplyFilterTap extends JobOfferListEvent {}

class FilterChipTap extends JobOfferListEvent {
  const FilterChipTap(this.filter);

  final Filter filter;

  @override
  List<Object> get props => [filter];
}

class EmptyFilterTap extends JobOfferListEvent {}
