import 'package:rxdart/subjects.dart';

class JobOffer {
  const JobOffer({required this.title});
  final String title;
}

class JobOfferRepository {
  final _jobOfferListController = BehaviorSubject<List<JobOffer>>();

  Stream<List<JobOffer>> get jobOfferList async* {
    yield* _jobOfferListController.stream;
  }

  Future<void> getJobOffers() async {
    _jobOfferListController.add([const JobOffer(title: 'First')]);
  }

  void dispose() {
    _jobOfferListController.close();
  }
}
