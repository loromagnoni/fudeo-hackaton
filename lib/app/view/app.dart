import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_list/job_list.dart';
import 'package:job_offer_repository/job_offer_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required JobOfferRepository jobOfferRepository})
      : _jobOfferRepository = jobOfferRepository;

  final JobOfferRepository _jobOfferRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _jobOfferRepository,
      child: const MaterialApp(
        home: JobListPage(),
      ),
    );
  }
}
