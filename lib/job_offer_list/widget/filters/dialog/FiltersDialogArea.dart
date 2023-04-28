import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/filters/dialog/FilterItem.dart';

class FiltersDialogArea extends StatelessWidget {
  const FiltersDialogArea({super.key, required Widget child}) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _child,
        Expanded(
          child: BlocBuilder<JobOfferListBloc, JobOfferListState>(
            builder: (context, state) {
              return Visibility(
                visible: state is OpportunityFilterEditing,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text('Filtri'),
                      ExpansionTile(
                        title: Text('Team'),
                        children: [
                          FilterItem(
                            filter: Filter.fullRemote,
                          ),
                          FilterItem(
                            filter: Filter.hybrid,
                          ),
                          FilterItem(
                            filter: Filter.onSite,
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text('Seniority'),
                        children: [
                          FilterItem(
                            filter: Filter.junior,
                          ),
                          FilterItem(
                            filter: Filter.mid,
                          ),
                          FilterItem(
                            filter: Filter.senior,
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text('Contratto'),
                        children: [
                          FilterItem(
                            filter: Filter.fullTime,
                          ),
                          FilterItem(
                            filter: Filter.partTime,
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () =>
                              BlocProvider.of<JobOfferListBloc>(context)
                                  .add(CancelFilterTap()),
                          child: Text('Annulla')),
                      TextButton(
                          onPressed: () =>
                              BlocProvider.of<JobOfferListBloc>(context)
                                  .add(ApplyFilterTap()),
                          child: Text('Applica'))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
