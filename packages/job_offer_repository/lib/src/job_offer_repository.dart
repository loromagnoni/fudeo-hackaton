import 'package:equatable/equatable.dart';
import 'package:rxdart/subjects.dart';

class JobOffer extends Equatable {
  const JobOffer({required this.title});
  final String title;

  @override
  List<Object> get props => [title];
}

class JobOfferRepository {
  final _jobOfferListController = BehaviorSubject<List<JobOffer>>();

  Stream<List<JobOffer>> get jobOfferList async* {
    yield* _jobOfferListController.stream;
  }

  Future<void> loadJobOffers() async {
    _jobOfferListController.add([const JobOffer(title: 'First')]);
  }

  void dispose() {
    _jobOfferListController.close();
  }
}
