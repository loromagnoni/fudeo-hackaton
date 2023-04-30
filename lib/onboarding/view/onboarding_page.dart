import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fudeo_hackaton/onboarding/widget/proceed_button.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:fudeo_hackaton/widget/conditional_flex_fit.dart';
import 'package:job_offer_repository/job_offer_repository.dart';
import 'package:sized_context/sized_context.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({
    super.key,
    required JobOfferRepository jobOfferRepository,
  }) {
    jobOfferRepository
      ..loadJobOffers()
      ..loadFreelanceProjects();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final large = context.diagonalInches >= 7;
    final medium = context.diagonalInches >= 4 && context.diagonalInches < 7;
    final small = context.diagonalInches < 4;
    final padding = large ? 64.0 : 28.0;
    final imageSize = small ? width * 0.6 : width * 0.8;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Builder(
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: padding),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: padding),
                    child: SvgPicture.asset(
                      'assets/onboarding.svg',
                      width: imageSize,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ConditionalFlexFit(
                            wrapWithFlexFit: small,
                            child: const Text(
                              'Trova il tuo \nprossimo \nlavoro',
                              style: AppFonts.onboardingTitle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ConditionalFlexFit(
                            wrapWithFlexFit: small,
                            child: Column(
                              children: const [
                                Text(
                                  'I migliori annunci di lavoro in Flutter \nselezionati per te da',
                                  textAlign: TextAlign.center,
                                  style: AppFonts.onboardingSubTitle,
                                ),
                                Text(
                                  'Offertedilavoroflutter.it',
                                  style: AppFonts.onboardingLink,
                                ),
                              ],
                            ),
                          ),
                          ConditionalFlexFit(
                            wrapWithFlexFit: small,
                            child: const ProceedButton(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
