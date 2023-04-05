import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';
import 'package:job_offer_repository/job_offer_repository.dart';

class JobOfferListPage extends StatelessWidget {
  const JobOfferListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => JobOfferListBloc(
          jobOfferRepository: context.read<JobOfferRepository>(),
        ),
        child: const JobListView(),
      ),
    );
  }
}

class JobListView extends StatelessWidget {
  const JobListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobOfferListBloc, JobOfferListState>(
      builder: (context, state) => ListView(
        children: List.of(
          state.jobOfferList.map(
            (e) => Text(e.title),
          ),
        ),
      ),
    );
  }
}
