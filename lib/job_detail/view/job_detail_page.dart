import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fudeo_hackaton/job_detail/widget/apply_button.dart';
import 'package:fudeo_hackaton/job_detail/widget/created_date.dart';
import 'package:fudeo_hackaton/job_detail/widget/widget.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/favourite_checkbox/view/favourite_checkbox.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:job_offer_repository/job_offer_repository.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class JobOfferDetailPage extends StatelessWidget {
  const JobOfferDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final jobOffer = context.read<JobOfferRepository>().getJobOfferById(id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const ActionButton(
            child: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.black,
            ),
          ),
        ),
        actions: [
          FavouriteCheckbox(id: id),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 32, 18, 180),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreatedDate(date: jobOffer.publishDate),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          jobOffer.title,
                          style: AppFonts.jobDetailTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SocialShare(jobOfferId: id),
                    ],
                  ),
                  const SizedBox(height: 32),
                  JobDetailInfoSubtitle(
                    icon: PhosphorIcons.regular.buildings,
                    text: jobOffer.company,
                  ),
                  const SizedBox(height: 32),
                  if (jobOffer.salary != null)
                    JobDetailInfoSubtitle(
                      icon: PhosphorIcons.regular.currencyEur,
                      text: jobOffer.salary!,
                    ),
                  const SizedBox(height: 32),
                  JobDetailInfoSubtitle(
                    icon: PhosphorIcons.regular.mapPin,
                    text: jobOffer.location,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (jobOffer.teamLocation != null)
                        JobDetailInfoCard(
                          text: stringFromTeamLocation(jobOffer.teamLocation),
                          icon: PhosphorIcons.regular.coffee,
                          filterText: 'Team',
                        ),
                      if (jobOffer.seniority != null)
                        JobDetailInfoCard(
                          text: stringFromSeniority(jobOffer.seniority!),
                          icon: PhosphorIcons.regular.code,
                          filterText: 'Seniority',
                        ),
                      if (jobOffer.contract != null)
                        JobDetailInfoCard(
                          text: stringFromContract(jobOffer.contract),
                          icon: PhosphorIcons.regular.clock,
                          filterText: 'Contratto',
                        ),
                    ],
                  ),
                  if (jobOffer.description != null)
                    Html(
                      data: jobOffer.description,
                      style: {
                        'body':
                            Style.fromTextStyle(AppFonts.jobDetailDescription),
                      },
                    ),
                ],
              ),
            ),
          ),
          ApplyButton(url: jobOffer.applyUrl),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.ultraLightGrey,
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
