import 'package:favourites_repository/favourites_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/favourites/bloc/favourites_bloc.dart';
import 'package:fudeo_hackaton/favourites/widget/no_favourites_message.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:fudeo_hackaton/widget/opportunity_card.dart';
import 'package:job_offer_repository/job_offer_repository.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            PhosphorIcons.regular.caretLeft,
            color: AppColors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Annunci salvati',
          style: AppFonts.jobListAppBar,
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      body: BlocProvider(
        create: (context) => FavouritesBloc(
          jobOfferRepository: context.read<JobOfferRepository>(),
          favouritesRepository: context.read<FavouritesRepository>(),
        ),
        child: const FavouriteListView(),
      ),
    );
  }
}

class FavouriteListView extends StatelessWidget {
  const FavouriteListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      color: AppColors.white,
      child: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) => state.favouriteOpportunities.isNotEmpty
            ? ListView(
                children: List.of(
                  state.favouriteOpportunities.map(
                    (o) => OpportunityCard(opportunity: o),
                  ),
                ),
              )
            : const NoFavouritesMessage(),
      ),
    );
  }
}
