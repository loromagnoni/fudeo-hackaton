class JobOffer {
  const JobOffer({required this.title});
  final String title;
}

class JobOfferRepository {
  Future<List<JobOffer>> getJobOffers() {
    return Future.value([const JobOffer(title: 'First')]);
  }
}
