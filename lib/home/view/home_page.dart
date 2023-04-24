import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fudeo_hackaton/home/bloc/home_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/job_offer_list.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:fudeo_hackaton/theme/shadows.dart';
import 'package:job_offer_repository/job_offer_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc(
              jobOfferRepository: context.read<JobOfferRepository>(),
            ),
        child: const HomeView());
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 10),
            Icon(
              Icons.brightness_5_sharp,
              size: 20,
              color: AppColors.navy,
            ),
            const SizedBox(width: 10),
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
              )),
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
                      Expanded(
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
                          child: Text('Vedi tutti'))
                    ],
                  ),
                  const SizedBox(height: 4),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is! HomeSuccess) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        children: [
                          for (var jobOffer in state.opportunities)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow:
                                        AppShadows.homeOpportunityCardShadows,
                                    color:
                                        AppColors.homeOpportunityCardBackground,
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                jobOffer.title,
                                                style: AppFonts
                                                    .homeOpportunityCardTitle,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.business_outlined,
                                                    size: 18,
                                                    color:
                                                        AppColors.extraDarkGrey,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      jobOffer.workWithOrFor,
                                                      style: AppFonts
                                                          .homeOpportunityCardSubtitle,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.bookmark_outline,
                                              size: 32,
                                              color: AppColors.sky,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Wrap(
                                        spacing: 8,
                                        children: [
                                          for (var feature in jobOffer.features)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                  color: AppColors.lightGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Text(
                                                feature,
                                                style: AppFonts
                                                    .homeOpportunityCardTag,
                                              ),
                                            )
                                        ],
                                      )
                                    ],
                                  )),
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
