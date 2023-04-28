import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/filters/labels.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ActiveFilters extends StatelessWidget {
  const ActiveFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobOfferListBloc, JobOfferListState>(
      builder: (context, state) {
        if (state.filter.filters.isEmpty) return Container();
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.filter.filters
                      .map((f) => FilterChip(filter: f))
                      .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class FilterChip extends StatelessWidget {
  const FilterChip({super.key, required Filter filter}) : _filter = filter;

  final Filter _filter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          border: Border.all(
            color: AppColors.sky,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => BlocProvider.of<JobOfferListBloc>(context).add(
                  FilterChipTap(_filter),
                ),
                child: Icon(
                  PhosphorIcons.regular.x,
                  color: AppColors.sky,
                  size: 14,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                stringFromFilter(_filter),
                style: AppFonts.filterChip,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
