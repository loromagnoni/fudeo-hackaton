import 'package:equatable/equatable.dart';
import 'package:fudeo_api/fudeo_api.dart';
import 'package:rxdart/subjects.dart';

enum TeamLocation { fullRemote, hybrid, onSite }

TeamLocation? teamLocationFromString(String? teamLocation) {
  if (teamLocation == null) return null;
  switch (teamLocation) {
    case 'Full Remote':
      return TeamLocation.fullRemote;
    case 'Ibrido':
      return TeamLocation.hybrid;
    case 'In sede':
      return TeamLocation.onSite;
    default:
      throw Exception('Invalid team location');
  }
}

class JobOffer extends Equatable {
  const JobOffer({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.contract,
    required this.teamLocation,
  });

  final String title;
  final String id;
  final String company;
  final String location;
  final String contract;
  final TeamLocation? teamLocation;

  @override
  List<Object?> get props =>
      [title, id, company, location, contract, teamLocation];
}

class Freelance extends Equatable {
  const Freelance({
    required this.id,
    required this.title,
    required this.nda,
    required this.workWith,
    required this.compensation,
  });

  final String title;
  final String id;
  final bool nda;
  final String workWith;
  final String compensation;

  @override
  List<Object?> get props => [title, id, nda, workWith, compensation];
}

class JobOfferRepository {
  JobOfferRepository({required FudeoAPI fudeoAPI}) : _fudeoAPI = fudeoAPI;
  final FudeoAPI _fudeoAPI;
  final _jobOfferListController = BehaviorSubject<List<JobOffer>>();
  final _freelanceListController = BehaviorSubject<List<Freelance>>();
  bool _loaded = false;

  Stream<List<JobOffer>> get jobOfferList async* {
    yield* _jobOfferListController.stream;
  }

  Stream<List<Freelance>> get freelanceList async* {
    yield* _freelanceListController.stream;
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
      _freelanceListController.add(response.toFreelanceProjectList());
      _loaded = true;
    }
  }

  void dispose() {
    _jobOfferListController.close();
    _freelanceListController.close();
  }
}

extension on NotionDatabaseQueryResponse<NotionJobOfferPage> {
  List<JobOffer> toJobOfferList() {
    return results
        .map(
          (e) => JobOffer(
            id: e.id,
            title: e.properties.name.title.first.text.content,
            company: e.properties.companyName.richText.first.text.content,
            location: e.properties.location.richText.isEmpty
                ? ''
                : e.properties.location.richText.first.text.content,
            contract: e.properties.contract.select?.name ?? '',
            teamLocation:
                teamLocationFromString(e.properties.team.select?.name),
          ),
        )
        .toList();
  }
}

extension on NotionDatabaseQueryResponse<NotionFreelanceProjectPage> {
  List<Freelance> toFreelanceProjectList() {
    return results
        .map(
          (e) => Freelance(
            id: e.id,
            title: e.properties.code.title.first.text.content,
            nda: e.properties.nda.select?.name == 'Sì',
            workWith: e.properties.relationship.select?.name ?? '',
            compensation: e.properties.budget.richText.first.text.content,
          ),
        )
        .toList();
  }
}
