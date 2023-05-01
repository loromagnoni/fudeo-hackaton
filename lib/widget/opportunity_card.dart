import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/home/bloc/home_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/widget.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:fudeo_hackaton/theme/shadows.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({
    super.key,
    required this.opportunity,
    required this.onTap,
  });

  final Opportunity opportunity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: AppShadows.homeOpportunityCardShadows,
            color: AppColors.homeOpportunityCardBackground,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          opportunity.title,
                          style: AppFonts.homeOpportunityCardTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              PhosphorIcons.regular.buildings,
                              size: 18,
                              color: AppColors.extraDarkGrey,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                opportunity.workWithOrFor,
                                style: AppFonts.homeOpportunityCardSubtitle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  FavouriteCheckbox(
                    id: opportunity.id,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 8,
                children: [
                  for (var feature in opportunity.features)
                    feature == ''
                        ? Container()
                        : Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              feature,
                              style: AppFonts.homeOpportunityCardTag,
                            ),
                          )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
