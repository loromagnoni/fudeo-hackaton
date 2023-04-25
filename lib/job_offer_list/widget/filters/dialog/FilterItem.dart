import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({super.key, required String label, required Filter filter})
      : _label = label,
        _filter = filter;

  final String _label;
  final Filter _filter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(_label),
        BlocBuilder<JobOfferListBloc, JobOfferListState>(
          builder: (context, state) {
            print((state as OpportunityFilterEditing).filterToApply.filters);
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
