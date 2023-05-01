import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/filters/dialog/filter_item.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';

class FilterGroup extends StatelessWidget {
  const FilterGroup({
    super.key,
    required this.title,
    required this.filters,
    required this.icon,
  });

  final String title;
  final List<Filter> filters;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: AppFonts.filtersDialogGroupTitle,
      ),
      leading: Icon(icon, color: AppColors.sky),
      tilePadding: EdgeInsets.zero,
      children: [
        ...filters.map(
          (filter) => FilterItem(
            filter: filter,
          ),
        ),
      ],
    );
  }
}
