import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fudeo_hackaton/home/bloc/home_bloc.dart';
import 'package:fudeo_hackaton/home/widget/opportunity_shimmer_card.dart';
import 'package:fudeo_hackaton/job_detail/job_detail.dart';
import 'package:fudeo_hackaton/job_offer_list/job_offer_list.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:fudeo_hackaton/widget/opportunity_card.dart';
import 'package:job_offer_repository/job_offer_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        jobOfferRepository: context.read<JobOfferRepository>(),
      ),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final aspectRatio = width / height;
    final usingSmallScreen = aspectRatio > 0.6;
    final imageSize = usingSmallScreen ? width * 0.7 : width * 0.8;

    return Scaffold(
      appBar: AppBar(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(width: 10),
            Icon(
              Icons.brightness_5_sharp,
              size: 20,
              color: AppColors.navy,
            ),
            SizedBox(width: 10),
            Text(
              'Light mode',
              style: AppFonts.label,
            )
          ],
        ),
        elevation: 0,
        leadingWidth: 100,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark_outline,
              size: 20,
              color: AppColors.black,
            ),
          ),
        ],
        backgroundColor: AppColors.blueShadesLight.withAlpha(50),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.blueShadesLight.withAlpha(50),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cosa cerchi?',
                    style: AppFonts.titleNav,
                    textAlign: TextAlign.left,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      'assets/hero.svg',
                      width: imageSize,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Ultimi annunci inseriti',
                          style: AppFonts.homeHeader,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => const JobOfferListPage(),
                            ),
                          );
                        },
                        child: const Text('Vedi tutti'),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is! HomeSuccess) {
                        return const LoadingListShimmers();
                      }
                      return Column(
                        children: [
                          for (var opportunity in state.opportunities)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (context) => opportunity.type ==
                                              OpportunityType.jobOffer
                                          ? JobOfferDetailPage(
                                              id: opportunity.id,
                                            )
                                          : Container(),
                                    ),
                                  );
                                },
                                child: Ink(
                                  child: OpportunityCard(
                                    opportunity: opportunity,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingListShimmers extends StatelessWidget {
  const LoadingListShimmers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < 3; i++)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: OpportunityShimmerCard(),
          ),
      ],
    );
  }
}
