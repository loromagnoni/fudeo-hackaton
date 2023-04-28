import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/no_results/empty_filters.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';

class NoResultsMessage extends StatelessWidget {
  const NoResultsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: SvgPicture.asset(
              'assets/no_result.svg',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: Column(
              children: const [
                Text(
                  'Non ci sono annunci corrispondenti alla tua ricerca!',
                  style: AppFonts.listNoResults,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                EmptyFilters(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
