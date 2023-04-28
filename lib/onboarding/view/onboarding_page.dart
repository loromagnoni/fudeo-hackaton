import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fudeo_hackaton/home/home.dart';
import 'package:fudeo_hackaton/onboarding/widget/proceed_button.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:fudeo_hackaton/widget/conditional_flex_fit.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final padding = height * 0.06;
    final aspectRatio = width / height;
    final usingSmallScreen = aspectRatio > 0.6;
    final imageSize = usingSmallScreen ? width * 0.6 : width * 0.8;

    return Scaffold(
      body: Padding(
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
                        wrapWithFlexFit: usingSmallScreen,
                        child: const Text(
                          'Trova il tuo \nprossimo \nlavoro',
                          style: AppFonts.onboardingTitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ConditionalFlexFit(
                        wrapWithFlexFit: usingSmallScreen,
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
                        wrapWithFlexFit: usingSmallScreen,
                        child: const ProceedButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
