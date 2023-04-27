import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/home/bloc/home_bloc.dart';
import 'package:fudeo_hackaton/job_detail/view/job_detail_page.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/widget.dart';
import 'package:fudeo_hackaton/project_detail/view/project_detail_page.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:fudeo_hackaton/theme/shadows.dart';

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({
    super.key,
    required this.opportunity,
  });

  final Opportunity opportunity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => opportunity.type == OpportunityType.jobOffer
                ? JobOfferDetailPage(
                    id: opportunity.id,
                  )
                : ProjectDetailPage(
                    id: opportunity.id,
                  ),
          ),
        );
      },
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
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        opportunity.title,
                        style: AppFonts.homeOpportunityCardTitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.business_outlined,
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
                  )),
                  FavouriteCheckbox(
                    id: opportunity.id,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: [
                  for (var feature in opportunity.features)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(8)),
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
