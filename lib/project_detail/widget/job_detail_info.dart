import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';

class JobDetailInfoSubtitle extends StatelessWidget {
  const JobDetailInfoSubtitle({
    required this.icon,
    required this.text,
    super.key,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.greyDark,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: AppFonts.jobDetailInfoSubtitle,
          ),
        ),
      ],
    );
  }
}

class JobDetailInfoCard extends StatelessWidget {
  const JobDetailInfoCard({
    required this.text,
    required this.icon,
    required this.filterText,
    super.key,
  });

  final String text;
  final IconData icon;
  final String filterText;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGrey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(text, style: AppFonts.jobDetailInfoCard),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(icon, size: 12, color: AppColors.sky),
                const SizedBox(width: 6),
                Text(filterText, style: AppFonts.jobDetailInfoCardFilter),
              ],
            )
          ],
        ),
      ),
    );
  }
}
