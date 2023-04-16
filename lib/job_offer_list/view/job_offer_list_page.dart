import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_detail/job_detail.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';
import 'package:job_offer_repository/job_offer_repository.dart';

class JobOfferListPage extends StatelessWidget {
  const JobOfferListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobOfferListBloc(
        jobOfferRepository: context.read<JobOfferRepository>(),
        openJobOfferDetailPage: (jobOffer) => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const JobOfferDetailPage(),
          ),
        ),
      ),
      child: Scaffold(
        body: const JobListView(),
        floatingActionButton: BlocBuilder<JobOfferListBloc, JobOfferListState>(
          builder: (context, state) =>
              state is JobOfferListFilled && state.hasMore
                  ? FloatingActionButton(
                      onPressed: () => _onLoadMore(context, state.nextCursor!),
                      child: const Icon(Icons.arrow_forward),
                    )
                  : Container(),
        ),
      ),
    );
  }

  void _onLoadMore(BuildContext context, String nextCursor) {
    BlocProvider.of<JobOfferListBloc>(context)
        .add(JobOfferListLoadMore(nextCursor));
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
            (e) => GestureDetector(
              child: Text(e.title),
              onTap: () => _onJobOfferTap(context, e),
            ),
          ),
        ),
      ),
    );
  }

  void _onJobOfferTap(BuildContext context, JobOffer e) {
    BlocProvider.of<JobOfferListBloc>(context).add(JobOfferListTap(e));
  }
}
