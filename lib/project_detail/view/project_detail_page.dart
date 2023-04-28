import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_detail/widget/apply_button.dart';
import 'package:fudeo_hackaton/job_detail/widget/created_date.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/favourite_checkbox/view/favourite_checkbox.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:job_offer_repository/job_offer_repository.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final project = context.read<JobOfferRepository>().getFreelanceById(id);
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
                  SizedBox(height: 32),
                  CreatedDate(date: project.publishDate),
                  Row(
                    children: [
                      Text(project.title),
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.share),
                      ),
                    ],
                  ),
                  Text(project.compensation),
                  Text(project.workWith),
                  if (project.nda) Text('NDA previsto'),
                  if (project.description != null) Text(project.description!),
                  if (project.request != null) Text(project.request!),
                  if (project.description != null) Text(project.description!),
                  if (project.description != null) Text(project.description!),
                  if (project.timeline != null) Text(project.timeline!),
                  if (project.payment != null) Text(project.payment!),
                ],
              ),
            ),
            ApplyButton(url: project.applyUrl),
          ],
        ));
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
