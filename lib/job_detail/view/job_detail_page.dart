import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        leadingWidth: 90,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SizedBox(
              width: 50,
              height: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.ultraLightGrey),
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.ultraLightGrey,
                ),
                child: Icon(
                  PhosphorIcons.regular.caretLeft,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: FavouriteCheckboxAction(id: id),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: _HeaderSection(jobOffer: jobOffer),
                ),
                Stack(
                  children: [
                    _DescriptionSection(jobOffer: jobOffer),
                    Positioned(
                      top: 0,
                      left: 18,
                      right: 18,
                      child: _InfoCards(jobOffer: jobOffer),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ApplyButton(url: jobOffer.applyUrl),
        ],
      ),
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({
    super.key,
    required this.jobOffer,
  });

  final JobOffer jobOffer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 64),
      padding: const EdgeInsets.only(
        top: 64,
        left: 18,
        right: 18,
        bottom: 92,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        color: AppColors.blueShadesLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const JobOfferDescriptionTitle(title: 'Descrizione'),
          const SizedBox(height: 4),
          Html(
            data: jobOffer.description,
            style: {
              'body': Style.fromTextStyle(AppFonts.jobDetailDescription),
            },
          ),
        ],
      ),
    );
  }
}

class _InfoCards extends StatelessWidget {
  const _InfoCards({
    super.key,
    required this.jobOffer,
  });

  final JobOffer jobOffer;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({
    super.key,
    required this.jobOffer,
  });

  final JobOffer jobOffer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CreatedDate(date: jobOffer.publishDate),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                jobOffer.title,
                style: AppFonts.jobDetailTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SocialShare(
              jobOfferId: jobOffer.id,
              isFreelance: false,
            ),
          ],
        ),
        const SizedBox(height: 32),
        JobDetailInfoSubtitle(
          icon: PhosphorIcons.regular.buildings,
          text: jobOffer.company,
        ),
        const Divider(height: 32),
        if (jobOffer.salary != null) ...[
          JobDetailInfoSubtitle(
            icon: PhosphorIcons.regular.currencyEur,
            text: jobOffer.salary!,
          ),
          const Divider(height: 32),
        ],
        JobDetailInfoSubtitle(
          icon: PhosphorIcons.regular.mapPin,
          text: jobOffer.location,
        ),
        const SizedBox(height: 32),
      ],
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

class JobOfferDescriptionTitle extends StatelessWidget {
  const JobOfferDescriptionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppFonts.jobDetailDescriptionTitle);
  }
}
