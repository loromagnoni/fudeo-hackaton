import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/no_results/empty_filters.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:sized_context/sized_context.dart';

class NoResultsMessage extends StatelessWidget {
  const NoResultsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final large = context.diagonalInches >= 7;
    final medium = context.diagonalInches >= 4 && context.diagonalInches < 7;
    final small = context.diagonalInches < 4;
    final verticalPadding = large ? 48.0 : 24.0;
    final imageSize = small ? width * 0.3 : width * 0.6;

    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
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
