import 'package:equatable/equatable.dart';
import 'package:fudeo_api/fudeo_api.dart';
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
  final _jobOfferListController = BehaviorSubject<List<JobOffer>>();
  bool _loaded = false;

  Stream<List<JobOffer>> get jobOfferList async* {
    yield* _jobOfferListController.stream;
  }

  Future<void> loadJobOffers() async {
    if (!_loaded) {
      final response = await _fudeoAPI.getJobOffers();
      _jobOfferListController.add(response.toJobOfferList());
      _loaded = true;
    }
  }

  Future<void> loadFreelanceProjects() async {
    if (!_loaded) {
      final response = await _fudeoAPI.getFreelanceProjects();
      _jobOfferListController.add(response.toFreelanceProjectList());
      _loaded = true;
    }
  }

  void dispose() {
    _jobOfferListController.close();
  }
}

extension on NotionDatabaseQueryResponse<NotionJobOfferPage> {
  List<JobOffer> toJobOfferList() {
    return results
        .map(
          (e) => JobOffer(
            title: e.properties.name.title.first.text.content,
          ),
        )
        .toList();
  }
}

extension on NotionDatabaseQueryResponse<NotionFreelanceProjectPage> {
  List<JobOffer> toFreelanceProjectList() {
    return results
        .map(
          (e) => JobOffer(
            title: e.properties.code.title.first.text.content,
          ),
        )
        .toList();
  }
}
