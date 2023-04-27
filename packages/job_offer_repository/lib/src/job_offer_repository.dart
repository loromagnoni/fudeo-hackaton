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

String stringFromTeamLocation(TeamLocation? teamLocation) {
  if (teamLocation == null) return '';
  switch (teamLocation) {
    case TeamLocation.fullRemote:
      return 'Full Remote';
    case TeamLocation.hybrid:
      return 'Ibrido';
    case TeamLocation.onSite:
      return 'In sede';
  }
}

String stringFromSeniority(Seniority seniority) {
  switch (seniority) {
    case Seniority.junion:
      return 'Junior';
    case Seniority.mid:
      return 'Mid';
    case Seniority.senior:
      return 'Senior';
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
    this.salary,
    this.description,
    this.applyUrl,
  });

  final String title;
  final String id;
  final String company;
  final String location;
  final String? salary;
  final Contract? contract;
  final TeamLocation? teamLocation;
  final Seniority? seniority;
  final String? description;
  final String? applyUrl;

  @override
  List<Object?> get props => [
        title,
        id,
        company,
        location,
        contract,
        teamLocation,
        seniority,
        salary,
        description,
        applyUrl
      ];
}

class Freelance extends Equatable {
  const Freelance({
    required this.id,
    required this.title,
    required this.nda,
    required this.workWith,
    required this.compensation,
    this.applyUrl,
    this.description,
    this.request,
    this.timeline,
    this.payment,
  });

  final String title;
  final String id;
  final bool nda;
  final String workWith;
  final String compensation;
  final String? description;
  final String? applyUrl;
  final String? request;
  final String? timeline;
  final String? payment;

  @override
  List<Object?> get props => [
        title,
        id,
        nda,
        workWith,
        compensation,
        description,
        applyUrl,
        request,
        timeline,
        payment
      ];
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

  JobOffer getJobOfferById(String id) {
    return _jobOfferListController.value.firstWhere(
      (element) => element.id == id,
    );
  }

  Freelance getFreelanceById(String id) {
    return _freelanceListController.value.firstWhere(
      (element) => element.id == id,
    );
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
            salary: e.properties.salary.richText.isEmpty
                ? null
                : e.properties.salary.richText.first.text.content,
            description: e.properties.description.richText.isEmpty
                ? null
                : e.properties.description.richText
                    .map((el) => el.text.content)
                    .join('\n'),
            applyUrl: e.properties.applicationProcess.richText.isEmpty
                ? null
                : e.properties.applicationProcess.richText.first.text.content,
          ),
        )
        .toList();
  }
}

// final String title;
// final String id;
// final bool nda;
// final String workWith;
// final String compensation;
// final String? description;
// final String? applyUrl;
// final String? request;
// final String? timeline;
// final String? payment;

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
            description: e.properties.description.richText
                .map((el) => el.text.content)
                .join('\n'),
            applyUrl:
                e.properties.applicationProcess.richText.first.text.content,
            request: e.properties.request.richText
                .map((el) => el.text.content)
                .join('\n'),
            timeline: e.properties.schedule.richText
                .map((el) => el.text.content)
                .join('\n'),
            payment: e.properties.paymentTiming.richText
                .map((el) => el.text.content)
                .join('\n'),
          ),
        )
        .toList();
  }
}
