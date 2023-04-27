part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];

  HomeState loadJobOffers(List<JobOffer> jobOffers) {
    return HomeJobOffersLoaded(jobOffers);
  }

  HomeState loadFreelanceProjects(List<Freelance> freelanceProjects) {
    return HomeFreelanceProjectsLoaded(freelanceProjects);
  }
}

class HomeJobOffersLoaded extends HomeState {
  const HomeJobOffersLoaded(this.jobOffers);

  final List<JobOffer> jobOffers;

  @override
  List<Object> get props => [jobOffers];

  HomeState loadFreelanceProjects(List<Freelance> freelanceProjects) {
    return HomeSuccess(jobOffers, freelanceProjects);
  }
}

class HomeFreelanceProjectsLoaded extends HomeState {
  const HomeFreelanceProjectsLoaded(this.freelanceProjects);

  final List<Freelance> freelanceProjects;

  @override
  List<Object> get props => [freelanceProjects];

  HomeState loadJobOffers(List<JobOffer> jobOffers) {
    return HomeSuccess(jobOffers, freelanceProjects);
  }
}

class HomeSuccess extends HomeState {
  const HomeSuccess(this.jobOffers, this.freelanceProjects);

  final List<JobOffer> jobOffers;
  final List<Freelance> freelanceProjects;

  List<Opportunity> get opportunities {
    return <Opportunity>[
      ...jobOffers.map(Opportunity.fromJobOffer),
      ...freelanceProjects.map(Opportunity.fromFreelance),
    ].take(3).toList();
  }

  @override
  List<Object> get props => [jobOffers, freelanceProjects];
}

class Opportunity extends Equatable {
  factory Opportunity.fromJobOffer(JobOffer jobOffer) {
    return Opportunity(
      id: jobOffer.id,
      title: jobOffer.title,
      workWithOrFor: jobOffer.company,
      features: [
        stringFromContract(jobOffer.contract),
        jobOffer.location,
      ],
      type: OpportunityType.jobOffer,
    );
  }

  factory Opportunity.fromFreelance(Freelance freelance) {
    return Opportunity(
      id: freelance.id,
      title: freelance.title,
      workWithOrFor: freelance.workWith,
      features: [
        freelance.compensation,
        freelance.nda ? 'NDA' : 'No NDA',
      ],
      type: OpportunityType.freelanceProject,
    );
  }

  const Opportunity({
    required this.id,
    required this.title,
    required this.workWithOrFor,
    required this.features,
    required this.type,
  });

  final String id;
  final String title;
  final String workWithOrFor;
  final List<String> features;
  final OpportunityType type;

  @override
  List<Object?> get props => [
        id,
        title,
        workWithOrFor,
        features,
      ];
}

enum OpportunityType {
  jobOffer,
  freelanceProject,
}
