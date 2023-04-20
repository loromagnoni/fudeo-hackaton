import 'package:favourites_repository/favourites_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/widget.dart';

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
      builder: (context, state) => Checkbox(
        value: state.checked,
        onChanged: (value) => context
            .read<FavouriteCheckboxBloc>()
            .add(const FavouriteCheckboxToggled()),
      ),
    );
  }
}
