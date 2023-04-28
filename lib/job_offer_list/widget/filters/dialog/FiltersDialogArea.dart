import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/filters/dialog/FilterItem.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/filters/dialog/filter_group.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FiltersDialogArea extends StatelessWidget {
  const FiltersDialogArea({super.key, required Widget child}) : _child = child;

  final Widget _child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        _child,
        Expanded(
          child: BlocBuilder<JobOfferListBloc, JobOfferListState>(
            builder: (context, state) {
              return Visibility(
                visible: state is OpportunityFilterEditing,
                child: Positioned(
                  right: 0,
                  child: Container(
                    width: width * 0.75,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.sky),
                      color: AppColors.accentLight,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filtri',
                            style: AppFonts.filtersDialogTitle,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          FilterGroup(
                            title: 'Team',
                            icon: PhosphorIcons.regular.users,
                            filters: [
                              Filter.fullRemote,
                              Filter.hybrid,
                              Filter.onSite,
                            ],
                          ),
                          FilterGroup(
                            title: 'Seniority',
                            icon: PhosphorIcons.regular.code,
                            filters: [
                              Filter.junior,
                              Filter.mid,
                              Filter.senior,
                            ],
                          ),
                          FilterGroup(
                            title: 'Contratto',
                            icon: PhosphorIcons.regular.clock,
                            filters: [
                              Filter.fullTime,
                              Filter.partTime,
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () =>
                                      BlocProvider.of<JobOfferListBloc>(context)
                                          .add(CancelFilterTap()),
                                  child: Text('Annulla',
                                      style: AppFonts.filtersDialogButton)),
                              SizedBox(
                                width: 12,
                              ),
                              TextButton(
                                  onPressed: () =>
                                      BlocProvider.of<JobOfferListBloc>(context)
                                          .add(ApplyFilterTap()),
                                  child: Text('Applica',
                                      style: AppFonts.filtersDialogButton))
                            ],
                          )
                        ],
                      ),
                    ),
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
