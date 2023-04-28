import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_detail/job_detail.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/filters/dialog/FiltersDialogArea.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/filters/filters.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/no_results/no_results_message.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/opportunity_type_toggle.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/widget.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:fudeo_hackaton/widget/opportunity_card.dart';
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
              builder: (context) => JobOfferDetailPage(
                id: jobOffer.id,
              ),
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
    return Container(
      padding: const EdgeInsets.all(32),
      color: AppColors.white,
      child: Column(
        children: [
          OpportunityTypeToggle(),
          Filters(),
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
    return FiltersDialogArea(
      child: BlocBuilder<JobOfferListBloc, JobOfferListState>(
        builder: (context, state) => state.filteredOpportunities.isNotEmpty
            ? ListView(
                children: List.of(
                  state.filteredOpportunities.map(
                    (o) => OpportunityCard(opportunity: o),
                  ),
                ),
              )
            : const NoResultsMessage(),
      ),
    );
  }

  void _onJobOfferTap(BuildContext context, JobOffer e) {
    BlocProvider.of<JobOfferListBloc>(context).add(JobOfferListTap(e));
  }
}
