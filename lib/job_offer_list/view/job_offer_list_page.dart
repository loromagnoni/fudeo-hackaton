import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_detail/job_detail.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/opportunity_type_toggle.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/widget.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:job_offer_repository/job_offer_repository.dart';

class JobOfferListPage extends StatelessWidget {
  const JobOfferListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Annunci',
          style: AppFonts.jobListAppBar,
        ),
        backgroundColor: AppColors.white,
      ),
      body: BlocProvider(
        create: (context) => JobOfferListBloc(
          jobOfferRepository: context.read<JobOfferRepository>(),
          openJobOfferDetailPage: (jobOffer) => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const JobOfferDetailPage(),
            ),
          ),
        ),
        child: const JobOfferListView(),
      ),
    );
  }
}

class JobOfferListView extends StatelessWidget {
  const JobOfferListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          OpportunityTypeToggle(),
          Text('filters'),
          Expanded(
            child: JobListView(),
          )
        ],
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
            (e) => GestureDetector(
              child: Row(
                children: [
                  Text(e.title),
                  FavouriteCheckbox(id: e.id),
                ],
              ),
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
