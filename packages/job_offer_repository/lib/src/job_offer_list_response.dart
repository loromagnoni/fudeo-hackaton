import 'package:job_offer_repository/job_offer_repository.dart';

class JobOfferListResponse {
  JobOfferListResponse({
    required this.jobOffers,
    required this.hasMore,
    required this.nextCursor,
  });

  final List<JobOffer> jobOffers;
  final bool hasMore;
  final String? nextCursor;
}
