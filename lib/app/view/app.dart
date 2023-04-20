import 'package:favourites_repository/favourites_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/view/job_offer_list_page.dart';
import 'package:job_offer_repository/job_offer_repository.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required JobOfferRepository jobOfferRepository,
    required FavouritesRepository favouritesRepository,
  })  : _jobOfferRepository = jobOfferRepository,
        _favouritesRepository = favouritesRepository;

  final JobOfferRepository _jobOfferRepository;
  final FavouritesRepository _favouritesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _jobOfferRepository),
        RepositoryProvider.value(value: _favouritesRepository)
      ],
      child: const MaterialApp(
        home: JobOfferListPage(),
      ),
    );
  }
}
