import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fudeo_hackaton/job_detail/widget/apply_button.dart';
import 'package:fudeo_hackaton/job_detail/widget/created_date.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/favourite_checkbox/view/favourite_checkbox.dart';
import 'package:fudeo_hackaton/project_detail/widget/job_detail_info.dart';
import 'package:fudeo_hackaton/project_detail/widget/social_share/view/social_share.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:job_offer_repository/job_offer_repository.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final project = context.read<JobOfferRepository>().getFreelanceById(id);
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
                _HeaderSection(project: project),
                _DescriptionSection(project: project)
              ],
            ),
          ),
          ApplyButton(url: project.applyUrl),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({
    super.key,
    required this.project,
  });

  final Freelance project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CreatedDate(date: project.publishDate),
        const SizedBox(height: 14),
        Row(
          children: [
            Flexible(
              child: Text(
                project.title,
                style: AppFonts.jobDetailTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SocialShare(jobOfferId: project.id),
          ],
        ),
        const SizedBox(height: 32),
        JobDetailInfoSubtitle(
          icon: PhosphorIcons.regular.buildings,
          text: project.workWith,
        ),
        const Divider(
          height: 32,
        ),
        JobDetailInfoSubtitle(
          icon: PhosphorIcons.regular.currencyEur,
          text: project.compensation,
        ),
        const Divider(
          height: 32,
        ),
        JobDetailInfoSubtitle(
          text: project.nda ? 'NDA previsto' : 'NDA non previsto',
          icon: PhosphorIcons.regular.warningDiamond,
        ),
        const SizedBox(height: 32),
      ]),
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({
    super.key,
    required this.project,
  });

  final Freelance project;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
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
          if (project.description != null) ...[
            const SizedBox(height: 8),
            const JobOfferDescriptionTitle(title: 'Descrizione progetto'),
            const SizedBox(height: 4),
            Html(
              data: project.description,
              style: {
                'body': Style.fromTextStyle(AppFonts.jobDetailDescription),
              },
            ),
          ],
          if (project.request != null) ...[
            const SizedBox(height: 8),
            const JobOfferDescriptionTitle(title: 'Richiesta di lavoro'),
            const SizedBox(height: 4),
            Html(
              data: project.request,
              style: {
                'body': Style.fromTextStyle(AppFonts.jobDetailDescription),
              },
            ),
          ],
          if (project.timeline != null) ...[
            const SizedBox(height: 8),
            const JobOfferDescriptionTitle(title: 'Tempistiche progetto'),
            const SizedBox(height: 4),
            Html(
              data: project.timeline,
              style: {
                'body': Style.fromTextStyle(AppFonts.jobDetailDescription),
              },
            ),
          ],
          if (project.payment != null) ...[
            const SizedBox(height: 8),
            const JobOfferDescriptionTitle(title: 'Tempistiche pagamento'),
            const SizedBox(height: 4),
            Html(
              data: project.payment,
              style: {
                'body': Style.fromTextStyle(AppFonts.jobDetailDescription),
              },
            ),
          ],
          const SizedBox(height: 92),
        ],
      ),
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

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.ultraLightGrey,
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
