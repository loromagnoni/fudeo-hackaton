import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:favourites_repository/favourites_repository.dart';

part 'favourite_checkbox_event.dart';
part 'favourite_checkbox_state.dart';

class FavouriteCheckboxBloc
    extends Bloc<FavouriteCheckboxToggled, FavouriteCheckboxState> {
  FavouriteCheckboxBloc({
    required String id,
    required FavouritesRepository favouritesRepository,
  })  : _favouriteRepository = favouritesRepository,
        _id = id,
        super(
          FavouriteCheckboxState(
            checked: favouritesRepository.isFavourite(id),
          ),
        ) {
    on<FavouriteCheckboxToggled>(_handleFavouriteCheckboxToggled);
  }

  final FavouritesRepository _favouriteRepository;
  final String _id;

  void _handleFavouriteCheckboxToggled(
    FavouriteCheckboxToggled event,
    Emitter<FavouriteCheckboxState> emit,
  ) {
    _favouriteRepository.toggleFavourite(_id);
    emit(
      FavouriteCheckboxState(
        checked: _favouriteRepository.isFavourite(_id),
      ),
    );
  }
}
