import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fudeo_hackaton/home/home.dart';
import 'package:fudeo_hackaton/job_offer_list/job_offer_list.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/onboarding.svg'),
          Text('Trova il tuo prossimo lavoro'),
          Text('I migliori annunci di lavoro in Flutter selezionati per te da'),
          Text('Offerte di lavoro'),
          FilledButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => HomePage(),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Prosegui'),
                Icon(Icons.arrow_right_sharp),
              ],
            ),
          )
        ],
      ),
    );
  }
}
