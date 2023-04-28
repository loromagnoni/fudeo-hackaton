import 'package:favourites_repository/favourites_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../theme/colors.dart';

class FavouriteCheckbox extends StatelessWidget {
  const FavouriteCheckbox({super.key, required String id}) : _id = id;

  final String _id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteCheckboxBloc(
        id: _id,
        favouritesRepository: context.read<FavouritesRepository>(),
      ),
      child: const ItemCheckBox(),
    );
  }
}

class ItemCheckBox extends StatelessWidget {
  const ItemCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCheckboxBloc, FavouriteCheckboxState>(
      bloc: context.read<FavouriteCheckboxBloc>(),
      builder: (context, state) => InkResponse(
        onTap: () => context.read<FavouriteCheckboxBloc>().add(
              const FavouriteCheckboxToggled(),
            ),
        child: Icon(
          state.checked
              ? PhosphorIcons.fill.bookmarkSimple
              : PhosphorIcons.regular.bookmarkSimple,
          size: 32,
          color: AppColors.sky,
        ),
      ),
    );
  }
}
