import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset('assets/onboarding.svg'),
        Text('Trova il tuo prossimo lavoro'),
        Text('I migliori annunci di lavoro in Flutter selezionati per te da'),
        Text('Offerte di lavoro'),
      ],
    );
  }
}
