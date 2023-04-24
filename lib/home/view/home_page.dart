import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fudeo_hackaton/job_offer_list/job_offer_list.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';

class HomePage extends StatelessWidget {
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
