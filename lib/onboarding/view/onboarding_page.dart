import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fudeo_hackaton/home/home.dart';
import 'package:fudeo_hackaton/job_offer_list/job_offer_list.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 64),
                child: SvgPicture.asset('assets/onboarding.svg'),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trova il tuo prossimo lavoro',
                        style: AppFonts.onboardingTitle,
                        textAlign: TextAlign.center,
                      ),
                      Column(
                        children: [
                          Text(
                              'I migliori annunci di lavoro in Flutter selezionati per te da',
                              textAlign: TextAlign.center,
                              style: AppFonts.onboardingSubTitle),
                          Text('Offertedilavoroflutter.it',
                              style: AppFonts.onboardingLink),
                        ],
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: AppColors.sky,
                            borderRadius:
                                BorderRadius.all(Radius.circular(1000))),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => HomePage(),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 12,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Prosegui',
                                    style: AppFonts.onboardingButton),
                                Icon(
                                  Icons.arrow_right_sharp,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
