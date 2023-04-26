import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/filters/search_bar/search_bar.dart';

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SearchBar()),
        BlocBuilder<JobOfferListBloc, JobOfferListState>(
          builder: (context, state) {
            return Visibility(
                visible: state.selectedType == OpportunityType.jobOffer,
                child: IconButton(
                    onPressed: () => BlocProvider.of<JobOfferListBloc>(context)
                        .add(OpportunityFilterTap()),
                    icon: Icon(Icons.filter_list_off)));
          },
        )
      ],
    );
  }
}
