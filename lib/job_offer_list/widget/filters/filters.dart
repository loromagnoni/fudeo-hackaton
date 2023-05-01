import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/filters/active_filters.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/filters/search_bar/search_bar.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: SearchBar()),
              SizedBox(
                width: 16,
              ),
              BlocBuilder<JobOfferListBloc, JobOfferListState>(
                builder: (context, state) {
                  final bloc = BlocProvider.of<JobOfferListBloc>(context);
                  return Visibility(
                    visible: state.selectedType == OpportunityType.jobOffer,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: state is OpportunityFilterEditing
                                ? AppColors.sky
                                : AppColors.ultraLightGrey,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            onPressed: () =>
                                BlocProvider.of<JobOfferListBloc>(context)
                                    .add(OpportunityFilterTap()),
                            icon: Icon(
                              PhosphorIcons.regular.slidersHorizontal,
                              color: state is OpportunityFilterEditing
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: state is! OpportunityFilterEditing &&
                              state.filter.filters.isNotEmpty,
                          child: Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.accent,
                              ),
                              width: 8,
                              height: 8,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
          ActiveFilters(),
        ],
      ),
    );
  }
}
