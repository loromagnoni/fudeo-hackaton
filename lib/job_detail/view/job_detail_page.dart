import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/favourite_checkbox/view/favourite_checkbox.dart';
import 'package:fudeo_hackaton/theme/colors.dart';

class JobOfferDetailPage extends StatelessWidget {
  const JobOfferDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
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
        body: Container(
          child: Column(
            children: const [
              SizedBox(height: 32),
              Text('41 giorni fa'),
            ],
          ),
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
