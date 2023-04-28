import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/filters/labels.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({super.key, required Filter filter}) : _filter = filter;

  final Filter _filter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(stringFromFilter(_filter)),
        BlocBuilder<JobOfferListBloc, JobOfferListState>(
          builder: (context, state) {
            return Checkbox(
              value: (state as OpportunityFilterEditing)
                  .filterToApply
                  .filters
                  .contains(_filter),
              onChanged: (_) => BlocProvider.of<JobOfferListBloc>(context)
                  .add(FilterTap(_filter)),
            );
          },
        )
      ],
    );
  }
}
