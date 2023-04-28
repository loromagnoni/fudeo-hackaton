import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.ultraLightGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(
              PhosphorIcons.regular.magnifyingGlass,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  cursorColor: AppColors.sky,
                  style: AppFonts.searchBar,
                  onChanged: (value) =>
                      BlocProvider.of<JobOfferListBloc>(context).add(
                    SearchTextChanged(value),
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintStyle: AppFonts.searchBarPlaceholder,
                    hintText: 'Cerca...',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
