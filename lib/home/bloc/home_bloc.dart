import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_offer_repository/job_offer_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required JobOfferRepository jobOfferRepository,
  }) : super(HomeInitial()) {
    on<HomeJobOffersChanged>(_handleJobOffersChanged);
    on<HomeFreelanceProjectsChanged>(_handleFreelanceProjectsChanged);

    jobOfferRepository.jobOfferList.listen((event) {
      add(HomeJobOffersChanged(event));
    });
    jobOfferRepository.freelanceList.listen((event) {
      add(HomeFreelanceProjectsChanged(event));
    });

    jobOfferRepository
      ..loadFreelanceProjects()
      ..loadJobOffers();
  }

  void _handleJobOffersChanged(
      HomeJobOffersChanged event, Emitter<HomeState> emit) {
    if (state is HomeFreelanceProjectsLoaded) {
      emit((state as HomeFreelanceProjectsLoaded)
          .loadJobOffers(event.jobOffers));
    } else if (state is HomeInitial) {
      emit((state as HomeInitial).loadJobOffers(event.jobOffers));
    }
  }

  void _handleFreelanceProjectsChanged(
      HomeFreelanceProjectsChanged event, Emitter<HomeState> emit) {
    if (state is HomeJobOffersLoaded) {
      emit((state as HomeJobOffersLoaded)
          .loadFreelanceProjects(event.freelanceProjects));
    } else if (state is HomeInitial) {
      emit((state as HomeInitial)
          .loadFreelanceProjects(event.freelanceProjects));
    }
  }
}
