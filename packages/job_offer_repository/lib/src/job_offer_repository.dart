import 'package:equatable/equatable.dart';
import 'package:fudeo_api/fudeo_api.dart';
import 'package:job_offer_repository/src/job_offer_list_response.dart';
import 'package:rxdart/subjects.dart';

class JobOffer extends Equatable {
  const JobOffer({required this.title});

  final String title;

  @override
  List<Object> get props => [title];
}

class JobOfferRepository {
  JobOfferRepository({required FudeoAPI fudeoAPI}) : _fudeoAPI = fudeoAPI;
  final FudeoAPI _fudeoAPI;
  final _jobOfferListController = BehaviorSubject<JobOfferListResponse>();
  bool _loaded = false;

  Stream<JobOfferListResponse> get jobOfferList async* {
    yield* _jobOfferListController.stream;
  }

  Future<void> loadJobOffers({
    String? cursor,
  }) async {
    if (!_loaded) {
      final response = await _fudeoAPI.getJobOffers(cursor: cursor);
      _jobOfferListController.add(response.toJobOfferListResponse());
      _loaded = true;
    }
  }

  Future<void> loadFreelanceProjects() async {
    if (!_loaded) {
      final response = await _fudeoAPI.getFreelanceProjects();
      _jobOfferListController.add(response.toFreelanceProjectListResponse());
      _loaded = true;
    }
  }

  void dispose() {
    _jobOfferListController.close();
  }
}

extension on NotionDatabaseQueryResponse<NotionJobOfferPage> {
  JobOfferListResponse toJobOfferListResponse() {
    return JobOfferListResponse(
      jobOffers: results
          .map(
            (e) => JobOffer(
              title: e.properties.name.title.first.text.content,
            ),
          )
          .toList(),
      hasMore: hasMore,
      nextCursor: nextCursor,
    );
  }
}

extension on NotionDatabaseQueryResponse<NotionFreelanceProjectPage> {
  JobOfferListResponse toFreelanceProjectListResponse() {
    return JobOfferListResponse(
      jobOffers: results
          .map(
            (e) => JobOffer(
              title: e.properties.code.title.first.text.content,
            ),
          )
          .toList(),
      hasMore: hasMore,
      nextCursor: nextCursor,
    );
  }
}
