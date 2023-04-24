import 'package:rxdart/rxdart.dart';

class FavouritesRepository {
  final _favouritesController = BehaviorSubject<List<String>>();

  Stream<List<String>> get favourites async* {
    yield* _favouritesController.stream;
  }

  bool isFavourite(String id) {
    return _favouritesController.valueOrNull?.contains(id) ?? false;
  }

  void toggleFavourite(String id) {
    if (_favouritesController.valueOrNull?.contains(id) ?? false) {
      _removeFavourite(id);
    } else {
      _saveFavourite(id);
    }
  }

  void _saveFavourite(String id) {
    final favourites = _favouritesController.valueOrNull ?? []
      ..add(id);
    _favouritesController.add(favourites);
  }

  void _removeFavourite(String id) {
    final favourites = _favouritesController.valueOrNull ?? []
      ..remove(id);
    _favouritesController.add(favourites);
  }

  void dispose() {
    _favouritesController.close();
  }
}
