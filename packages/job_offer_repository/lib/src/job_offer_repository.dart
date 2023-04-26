import 'package:equatable/equatable.dart';
import 'package:fudeo_api/fudeo_api.dart';
import 'package:rxdart/subjects.dart';

enum TeamLocation { fullRemote, hybrid, onSite }

enum Contract { fullTime, partTime }

enum Seniority { junion, mid, senior }

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

Seniority? seniorityFromString(String? seniority) {
  if (seniority == null) return null;
  switch (seniority) {
    case 'Junior':
      return Seniority.junion;
    case 'Mid':
      return Seniority.mid;
    case 'Senior':
      return Seniority.senior;
    default:
      throw Exception('Invalid seniority');
  }
}

Contract? contractFromString(String? contract) {
  if (contract == null) return null;
  switch (contract) {
    case 'Full time':
      return Contract.fullTime;
    case 'Part time':
      return Contract.partTime;
    default:
      throw Exception('Invalid contract');
  }
}

String stringFromContract(Contract? contract) {
  if (contract == null) return '';
  switch (contract) {
    case Contract.fullTime:
      return 'Full time';
    case Contract.partTime:
      return 'Part time';
  }
}

class JobOffer extends Equatable {
  const JobOffer({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    this.seniority,
    this.contract,
    this.teamLocation,
  });

  final String title;
  final String id;
  final String company;
  final String location;
  final Contract? contract;
  final TeamLocation? teamLocation;
  final Seniority? seniority;

  @override
  List<Object?> get props =>
      [title, id, company, location, contract, teamLocation, seniority];
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
            contract: contractFromString(e.properties.contract.select?.name),
            teamLocation:
                teamLocationFromString(e.properties.team.select?.name),
            seniority: seniorityFromString(e.properties.seniority.select?.name),
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
