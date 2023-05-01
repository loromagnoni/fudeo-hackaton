import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fudeo_hackaton/favourites/view/favourite_page.dart';
import 'package:fudeo_hackaton/home/bloc/home_bloc.dart';
import 'package:fudeo_hackaton/home/widget/opportunity_shimmer_card.dart';
import 'package:fudeo_hackaton/job_offer_list/job_offer_list.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:fudeo_hackaton/widget/opportunity_card.dart';
import 'package:job_offer_repository/job_offer_repository.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
      body: ColoredBox(
        color: AppColors.white,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.blueShadesLight,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: IconButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const FavouritePage(),
                              ),
                            ),
                            icon: Icon(
                              PhosphorIcons.regular.bookmarkSimple,
                              size: 28,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
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
                          child: const Text(
                            'Vedi tutti',
                            style: AppFonts.homeCaption,
                          ),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: OpportunityCard(
                                  opportunity: opportunity,
                                ),
                              ),
                            const SizedBox(
                              height: 48,
                            )
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
