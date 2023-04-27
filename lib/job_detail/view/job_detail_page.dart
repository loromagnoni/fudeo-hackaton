import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_detail/widget/apply_button.dart';
import 'package:fudeo_hackaton/job_detail/widget/created_date.dart';
import 'package:fudeo_hackaton/job_detail/widget/widget.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/favourite_checkbox/view/favourite_checkbox.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:job_offer_repository/job_offer_repository.dart';

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
            child: Column(
              children: [
                const SizedBox(height: 32),
                const CreatedDate(),
                Row(
                  children: [
                    Text(jobOffer.title),
                    SocialShare(jobOfferId: id),
                  ],
                ),
                Text(jobOffer.company),
                if (jobOffer.salary != null) Text(jobOffer.salary!),
                Text(jobOffer.location),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (jobOffer.teamLocation != null)
                      Text(stringFromTeamLocation(jobOffer.teamLocation)),
                    if (jobOffer.seniority != null)
                      Text(stringFromSeniority(jobOffer.seniority!)),
                    if (jobOffer.contract != null)
                      Text(stringFromContract(jobOffer.contract)),
                  ],
                ),
                if (jobOffer.description != null) Text(jobOffer.description!)
              ],
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
